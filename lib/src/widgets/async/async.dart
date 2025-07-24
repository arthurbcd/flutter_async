import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../flutter_async.dart';
import '../../utils/adaptive_theme.dart';

/// A signature for the `AsyncBuilder` function.
typedef DataBuilder<T> = Widget Function(BuildContext context, T data);

/// A signature for the [Async.errorBuilder] function.
typedef ErrorBuilder =
    Widget Function(BuildContext context, Object error, StackTrace stackTrace);

/// A signature for the [Async.loadingBuilder] function.
typedef ThemeBuilder = ThemeData Function(BuildContext context);

typedef AsyncButtonLogger =
    void Function(AsyncButtonEvent event, AsyncButtonState state);

/// Async scope for flutter_async.
class Async extends StatelessWidget {
  /// Creates an [Async] widget.
  const Async({super.key, required this.config, required this.child});

  /// The config to be providen below this [Async].
  final AsyncConfig config;

  /// The child of this [Async].
  final Widget child;

  /// Returns the [AsyncConfig] of the nearest [Async] or default.
  static AsyncConfig of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_InheritedAsync>();
    return scope?.config ?? const AsyncConfig();
  }

  /// The [GlobalKey] to use as the root [NavigatorState].
  ///
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: Async.navigatorKey,
  /// )
  /// ```
  ///
  /// If `go_router`:
  /// ```dart
  /// GoRouter(
  ///   navigatorKey: Async.navigatorKey,
  /// )
  /// ```
  ///
  /// You can either use this or set your own [GlobalKey] here.
  ///
  /// The [GlobalKey.currentContext] will be used when showing dialogs or snackbars.:
  /// - [AsyncFutureExtension.showLoading]
  /// - [AsyncSnackBar.showSnackBar].
  ///
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// Adds a error translator to any [Async.message].
  ///
  /// You can use this to translate errors to a more user-friendly message.
  ///
  /// ```dart
  /// Async.translator = (e) => switch (e) {
  ///   ArgumentError e => '${e.name} is invalid',
  ///   _ => Async.defaultMessage,
  /// }
  /// ```
  static String Function(Object? e) translator = defaultMessage;

  /// Extracts the message of an error.
  ///
  /// This is used by any [Async.errorBuilder]. You can override this
  /// by setting [Async.translator].
  ///
  static String message(Object? e) => translator(e);

  /// The default logger for [AsyncButton] events.
  ///
  /// You can override this by setting [Async.buttonLogger].
  static AsyncButtonLogger? buttonLogger = (
    AsyncButtonEvent event,
    AsyncButtonState state,
  ) {
    if (kDebugMode) {
      var message = '${state.widget.tag ?? state.button} ${event.name}';
      if (state.buttonText case final text?) {
        message += ' "$text"';
      }
      log(
        '$message ${state.snapshot.errorMessage ?? ''}',
        name: 'Async.buttonLogger',
      );
    }
  };

  /// The default logger for any error.
  ///
  /// You can override this by setting [Async.errorLogger].
  static void Function(Object e, StackTrace s)? errorLogger = (e, s) {
    if (kDebugMode) {
      log(Async.message(e), error: e, stackTrace: s, name: 'Async.errorLogger');
    }
  };

  /// The library default error message.
  static String defaultMessage(Object? e) {
    try {
      if (e is ParallelWaitError<dynamic, Iterable>) {
        final messages = e.errors.map(Async.message);
        return messages.map((e) => e.endsWith('.') ? e : '$e.').join(' ');
      }
      if (e is Exception) return e.message;
    } catch (_) {}
    return e.toString();
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

    final message = Async.message(e);

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

  /// Returns [AsyncConfig.scrollLoadingBuilder] or default.
  static Widget scrollLoadingBuilder(BuildContext context) {
    final builder = of(context).scrollLoadingBuilder;
    if (builder != null) return builder(context);

    return SizedBox(height: 60, child: Async.loadingBuilder(context));
  }

  /// Returns the default [ThemeData] for error state.
  @Deprecated('Use errorTheme instead.')
  static ThemeData errorThemer(BuildContext context) => errorTheme(context);

  /// Returns the default [ThemeData] for error state.
  static ThemeData errorTheme(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: theme.colorScheme.error,
        brightness: theme.brightness,
      ),
    );
  }

  /// Returns the default [ThemeData] for loading state.
  @Deprecated('Use loadingTheme instead.')
  static ThemeData loadingThemer(BuildContext context) => loadingTheme(context);

  /// Returns the default [ThemeData] for loading state.
  static ThemeData loadingTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme;
  }

  /// Returns the default [ThemeData] for success state.
  @Deprecated('Use successTheme instead.')
  static ThemeData successThemer(BuildContext context) => successTheme(context);

  /// Returns the default [ThemeData] for success state.
  static ThemeData successTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme;
  }

  /// Shortcut to get the root [NavigatorState.context].
  ///
  /// We recommend setting [Async.navigatorKey] on your [MaterialApp] or router.
  static BuildContext get context {
    return navigatorKey.currentContext ??
        // we'll try to find it, not recommended.
        WidgetsBinding.instance.navigator.context;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return _InheritedAsync(config: config, child: child);
      },
    );
  }
}

extension on WidgetsBinding {
  /// Returns the root [NavigatorState].
  NavigatorState get navigator {
    final context = focusManager.rootScope.descendants.first.context; // leaf
    return Navigator.of(context!, rootNavigator: true);
  }
}

class _InheritedAsync extends InheritedWidget {
  const _InheritedAsync({required this.config, required super.child});

  /// The [AsyncConfig] of this [BuildContext].
  final AsyncConfig config;

  @override
  bool updateShouldNotify(_InheritedAsync oldWidget) => false;
}

/// Message of an exception.
extension AsyncMessageException on Exception {
  /// Returns the message of this exception.
  String get message {
    try {
      return (this as dynamic).message as String;
    } catch (_) {
      return toString();
    }
  }
}
