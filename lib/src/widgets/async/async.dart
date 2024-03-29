import 'package:flutter/material.dart';

import '../../configs/async_config.dart';
import '../../utils/adaptive_theme.dart';
import '../async_indicator/async_indicator.dart';

/// A signature for the `AsyncBuilder` function.
typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

/// A signature for the [Async.errorBuilder] function.
typedef ErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace stackTrace,
);

/// A signature for the [Async.loadingBuilder] function.
typedef AsyncThemeBuilder = ThemeData Function(BuildContext context);

/// Async scope for flutter_async.
class Async extends StatelessWidget {
  /// Creates an [Async] widget.
  const Async({
    super.key,
    required this.config,
    required this.child,
  });

  /// The config to be providen below this [Async].
  final AsyncConfig config;

  /// The child of this [Async].
  final Widget child;

  /// Returns the [AsyncConfig] of the nearest [Async] or default.
  static AsyncConfig of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_InheritedAsync>();
    return scope?.config ?? const AsyncConfig();
  }

  /// Returns [AsyncConfig.noneBuilder] or default.
  static Widget noneBuilder(BuildContext context) {
    final builder = of(context).noneBuilder;
    if (builder != null) return builder(context);

    // default
    return const Text('-');
  }

  /// Returns [AsyncConfig.errorBuilder] or default.
  static Widget errorBuilder(BuildContext context, Object e, StackTrace s) {
    final builder = of(context).errorBuilder;
    if (builder != null) return builder(context, e, s);

    // default
    var message = e.toString();
    try {
      // ignore: avoid_dynamic_calls
      if (e is Exception) message = (e as dynamic).message as String;
    } catch (_) {}

    final layout = LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 120) return Text(message);
        return Tooltip(
          message: message,
          child: SizedBox(
            width: constraints.maxWidth,
            child: const Text('!', textAlign: TextAlign.center),
          ),
        );
      },
    );

    return AdaptiveTheme(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [layout],
      ),
    );
  }

  /// Returns [AsyncConfig.loadingBuilder] or default.
  static Widget loadingBuilder(BuildContext context) {
    final builder = of(context).loadingBuilder;
    if (builder != null) return builder(context);

    // default
    return const AsyncIndicator();
  }

  /// Returns [AsyncConfig.reloadingBuilder] or default.
  static Widget reloadingBuilder(BuildContext context) {
    final builder = of(context).reloadingBuilder;
    if (builder != null) return builder(context);

    // default
    return Align(
      alignment: Alignment.topCenter,
      child: AsyncIndicator.linear(),
    );
  }

  /// Returns the default [ThemeData] for error state.
  static ThemeData errorThemer(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: theme.colorScheme.error,
        brightness: theme.brightness,
      ),
    );
  }

  /// Returns the default [ThemeData] for success state.
  static ThemeData successThemer(BuildContext context) {
    final theme = Theme.of(context);
    return theme;
  }

  /// Returns the default [ThemeData] for loading state.
  static ThemeData loadingThemer(BuildContext context) {
    final theme = Theme.of(context);
    return theme;
  }


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return _InheritedAsync(
          config: config,
          child: child,
        );
      },
    );
  }
}

class _InheritedAsync extends InheritedWidget {
  const _InheritedAsync({
    required this.config,
    required super.child,
  });

  /// The [AsyncConfig] of this [BuildContext].
  final AsyncConfig config;

  @override
  bool updateShouldNotify(_InheritedAsync oldWidget) => false;
}
