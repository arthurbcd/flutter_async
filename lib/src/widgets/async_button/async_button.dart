// ignore_for_file: strict_raw_type

import 'dart:async';

import 'package:async_notifier/async_notifier.dart';
import 'package:flutter/material.dart';

import '../../configs/async_config.dart';
import '../../extensions/element.dart';
import '../../utils/async_state.dart';
import '../async/async.dart';
import '../async_builder/async_builder.dart';

/// A [GlobalKey] that can be used to access the [AsyncButtonState] or
/// [AsyncBuilderState] of an [AsyncButton] or [AsyncBuilder].
///
/// This key can be used to programmatically trigger the button's
/// [AsyncButton.onPressed] or [AsyncButton.onLongPress] callbacks,
/// or to access the current state of the [AsyncButton] or
/// [AsyncBuilder] widget.
class AsyncKey<T> extends GlobalKey {
  /// Creates a new [AsyncKey] with the given [value].
  AsyncKey([this.value]) : super.constructor();

  /// The [value] of this key.
  ///
  /// If null, the key is considered to be a "default" [GlobalKey].
  /// If not null, it will behave like a [GlobalObjectKey].
  final Object? value;

  @override
  bool operator ==(Object other) {
    if (value == null) {
      return super == other;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AsyncKey<T> && identical(other.value, value);
  }

  @override
  int get hashCode {
    if (value == null) {
      return super.hashCode;
    }
    return identityHashCode(value);
  }

  AsyncButtonState? get currentButton {
    return currentContext?.findAncestorStateOfType<AsyncButtonState>();
  }

  AsyncBuilderState<T>? get currentBuilder {
    return currentContext?.findAncestorStateOfType<AsyncBuilderState<T>>();
  }

  @override
  String toString() => 'AsyncKey($value)';
}

///
class AsyncButton extends StatefulWidget {
  ///
  const AsyncButton({
    super.key,
    this.tag,
    this.config = const AsyncButtonConfig(),
    this.configurator,
    this.onPressed,
    this.onLongPress,
    required this.child,
    required this.builder,
  });

  /// Returns the [AsyncButtonState] of the nearest [AsyncButton] ancestor.
  static AsyncButtonState of(BuildContext context) {
    final state = context.findAncestorStateOfType<AsyncButtonState>();
    if (state == null) {
      throw StateError(
        'AsyncButton.of() called with a context that does not contain an AsyncButton.',
      );
    }
    return state;
  }

  /// The tag of this button. Used for debugging and logging purposes.
  final String? tag;

  /// The onPressed callback.
  final VoidCallback? onPressed;

  /// The onLongPress callback.
  final VoidCallback? onLongPress;

  /// The config of this button.
  final AsyncButtonConfig config;

  /// The optional configurator of this button.
  ///
  /// If defined, merges [config] with [configurator] result. Useful for inheritance.
  final AsyncButtonConfigurator? configurator;

  /// The child of [AsyncButton].
  final Widget child;

  /// The builder of [AsyncButton].
  final AsyncButtonStateBuilder builder;

  @override
  State<AsyncButton> createState() => AsyncButtonState();
}

enum AsyncButtonEvent {
  /// The button was pressed.
  pressed,

  /// The button was long pressed.
  longPressed,

  /// The button completed successfully.
  success,

  /// The button completed with an error.
  error,
}

/// The [AsyncState] of [AsyncButton].
class AsyncButtonState extends AsyncState<AsyncButton, void> {
  AsyncButtonResolvedConfig get _config {
    return widget.config
        .merge(widget.configurator?.call(context))
        .merge(Async.of(context).buttonConfig)
        .resolve();
  }

  /// Invokes [AsyncButton.onPressed] programatically.
  Future<void> press() async {
    if (widget.onPressed != null && !snapshot.isLoading) {
      async.future = Future(widget.onPressed!);
      Async.buttonLogger?.call(AsyncButtonEvent.pressed, this);
      return async.future;
    }
  }

  /// Returns either [press] or null.
  VoidCallback? get onPressed => widget.onPressed != null ? press : null;

  /// Invokes [AsyncButton.onLongPress] programatically.
  Future<void> longPress() async {
    if (widget.onLongPress != null && !snapshot.isLoading) {
      async.future = Future(widget.onLongPress!);
      Async.buttonLogger?.call(AsyncButtonEvent.longPressed, this);
      return async.future;
    }
  }

  /// Returns either [longPress] or null.
  VoidCallback? get onLongPress =>
      widget.onLongPress != null ? longPress : null;

  Widget? button;
  String? buttonText;

  void _setSize(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _size ??= context.size;

      context.visit(
        onWidget: (widget) {
          if (widget case Text text) {
            buttonText =
                text.data ??
                text.textSpan?.toPlainText(
                  includeSemanticsLabels: false,
                  includePlaceholders: false,
                );

            return false; // stop visiting
          }
          if (widget case Icon icon) {
            buttonText = icon.icon?.toString() ?? icon.semanticLabel;

            return false; // stop visiting
          }

          return true; // continue visiting
        },
      );
    });
  }

  void _reset() {
    async.value = const AsyncSnapshot.nothing();
  }

  @override
  void onSnapshot(AsyncSnapshot<void> snapshot) {
    _successTimer?.cancel();
    _errorTimer?.cancel();

    // resets button state after success/error duration
    snapshot.whenOrNull(
      data: (_) {
        Async.buttonLogger?.call(AsyncButtonEvent.success, this);
        return _successTimer = Timer(_config.successDuration, _reset);
      },
      error: (e, s) {
        Async.buttonLogger?.call(AsyncButtonEvent.error, this);
        return _errorTimer = Timer(_config.errorDuration, _reset);
      },
    );
    super.onSnapshot(snapshot);
  }

  @override
  void dispose() {
    _successTimer?.cancel();
    _errorTimer?.cancel();
    super.dispose();
  }

  Timer? _successTimer;
  Timer? _errorTimer;
  Size? _size;

  @override
  Widget build(BuildContext context) {
    final snapshot = async.snapshot;

    final child = Builder(
      builder: (context) {
        if (_size == null) _setSize(context);

        var child = snapshot.when(
          none: () => widget.child,
          loading: () => _config.loadingBuilder(context),
          error: (e, s) => _config.errorBuilder(context, e, s),
          data: (_) => _config.successBuilder?.call(context) ?? widget.child,
        );

        if (_config.animateSize) {
          child = AnimatedSize(
            alignment: _config.animatedSizeConfig.alignment,
            duration: _config.animatedSizeConfig.duration,
            reverseDuration: _config.animatedSizeConfig.reverseDuration,
            curve: _config.animatedSizeConfig.curve,
            clipBehavior: _config.animatedSizeConfig.clipBehavior,
            child: child,
          );
        }

        return SizedBox(
          height: _config.keepHeight ? _size?.height : null,
          width: _config.keepWidth ? _size?.width : null,
          child: child,
        );
      },
    );

    return AnimatedTheme(
      duration: _config.styleDuration,
      curve: _config.styleCurve,
      data: snapshot.when(
        none: () => Theme.of(context),
        loading: () => _config.loadingTheme(context),
        error: (e, s) => _config.errorTheme(context),
        data: (_) => _config.successTheme(context),
      ),
      child: button = widget.builder(context, this, child),
    );
  }
}

/// Signature for a function that creates a [Widget] for [AsyncButton].
typedef AsyncButtonStateBuilder =
    Widget Function(BuildContext context, AsyncButtonState state, Widget child);

/// Signature for a function that creates a [AsyncButtonConfig].
typedef AsyncButtonConfigurator =
    AsyncButtonConfig? Function(BuildContext context);
