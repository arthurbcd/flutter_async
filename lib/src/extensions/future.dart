import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/async/async.dart';

extension AsyncFutureExtension<T> on Future<T> {
  /// Completes either with [onValue] or null.
  Future<T?> thenOrNull(FutureOr<T?> Function(T value) onValue) {
    return then((value) => onValue(value), onError: (_) => null);
  }

  /// Silently catches errors and returns null.
  Future<T?> orNull() {
    return thenOrNull((value) => value);
  }

  /// Completes with either `true` or `false`.
  Future<bool> orFalse() {
    return then((_) => true, onError: (_) => false);
  }

  /// Shows a loading dialog.
  Future<T> showLoading() async {
    BuildContext? popContext;
    var didComplete = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (didComplete) return;

      showDialog<void>(
        context: Async.context,
        barrierDismissible: false,
        builder: (context) => Async.loadingBuilder(popContext = context),
      ).ignore();
    });

    return whenComplete(() {
      didComplete = true;
      if (popContext != null) Navigator.pop(popContext!);
    });
  }
}

/// Signature for a function that creates a [SnackBar].
typedef SnackBarBuilder =
    SnackBar Function(BuildContext context, String message);

extension AsyncSnackBar<T> on Future<T> {
  /// The default success snackbar to use on [showSnackBar].
  static SnackBarBuilder successBuilder = (context, message) {
    return SnackBar(content: SelectableText(message));
  };

  /// The default error snackbar to use on [showSnackBar].
  static SnackBarBuilder errorBuilder = (context, message) {
    final theme = Theme.of(context);

    return SnackBar(
      content: SelectableText(message),
      backgroundColor: theme.colorScheme.error,
    );
  };

  /// The default [AnimationStyle] to use on [showSnackBar].
  static AnimationStyle? animationStyle;

  /// Shows a success [SnackBar].
  /// You can customize the snackbar by setting [AsyncSnackBar.successBuilder].
  static void showSuccess(String message, {BuildContext? context}) {
    ScaffoldMessenger.of(context ??= Async.context).showSnackBar(
      successBuilder(context, message),
      snackBarAnimationStyle: animationStyle,
    );
  }

  /// Shows an error [SnackBar].
  /// You can customize the snackbar by setting [AsyncSnackBar.errorBuilder].
  static void showError(Object error, {BuildContext? context}) {
    ScaffoldMessenger.of(context ??= Async.context).showSnackBar(
      errorBuilder(context, Async.message(error)),
      snackBarAnimationStyle: animationStyle,
    );
  }

  /// Shows a [SnackBar] on success or error.
  ///
  /// - Shows [errorMessage] on error. By default, shows `Async.message(e)`.
  /// - Shows [successMessage] on success. By default, shows nothing.
  ///
  /// You can customize the snackbar by setting:
  /// - [AsyncSnackBar.successBuilder]
  /// - [AsyncSnackBar.errorBuilder]
  /// - [AsyncSnackBar.animationStyle]
  ///
  /// If [context] is null, uses [Async.context].
  Future<T> showSnackBar({
    BuildContext? context,
    String? successMessage,
    String? errorMessage,
  }) {
    return then(
      (value) {
        if (successMessage != null) {
          showSuccess(successMessage, context: context);
        }
        return value;
      },
      onError: (Object e, StackTrace s) {
        showError(errorMessage ?? e, context: context);
        Error.throwWithStackTrace(e, s);
      },
    );
  }
}

final _debouncers = <Object, (Completer<dynamic>, Timer)>{};
final _throttlers = <Object, (Completer<dynamic>, Timer)>{};

extension FutureFunctionExtensions<T, R> on Future<R> Function() {
  Future<R> Function() debounceTime(Duration duration) {
    return () {
      final debouncer = _debouncers[this]?..$2.cancel();

      final cp = debouncer?.$1 as Completer<R>? ?? Completer();
      _debouncers[this] = (cp, Timer(duration, () => cp.complete(this())));

      return cp.future.whenComplete(() => _debouncers.remove(this));
    };
  }

  Future<R> Function() throttleTime(Duration duration) {
    return () {
      if (_throttlers[this]?.$1.future case Future<R> future) return future;

      final cp = Completer<R>()..complete(this());
      _throttlers[this] = (cp, Timer(duration, () => _throttlers.remove(this)));

      return cp.future;
    };
  }
}

extension FutureFunctionExtensions1<T, R> on Future<R> Function(T) {
  Future<R> Function(T) debounceTime(Duration duration) {
    return (T arg) {
      final debouncer = _debouncers[this]?..$2.cancel();

      final cp = debouncer?.$1 as Completer<R>? ?? Completer();
      _debouncers[this] = (cp, Timer(duration, () => cp.complete(this(arg))));

      return cp.future.whenComplete(() => _debouncers.remove(this));
    };
  }

  Future<R> Function(T) throttleTime(Duration duration) {
    return (T arg) {
      if (_throttlers[this]?.$1.future case Future<R> future) return future;

      final cp = Completer<R>()..complete(this(arg));
      _throttlers[this] = (cp, Timer(duration, () => _throttlers.remove(this)));

      return cp.future;
    };
  }
}

extension FutureFunctionExtensions2<T1, T2, R> on Future<R> Function(T1, T2) {
  Future<R> Function(T1, T2) debounceTime(Duration duration) {
    return (T1 a, T2 b) {
      final debouncer = _debouncers[this]?..$2.cancel();

      final cp = debouncer?.$1 as Completer<R>? ?? Completer();
      _debouncers[this] = (cp, Timer(duration, () => cp.complete(this(a, b))));

      return cp.future.whenComplete(() => _debouncers.remove(this));
    };
  }

  Future<R> Function(T1, T2) throttleTime(Duration duration) {
    return (T1 a, T2 b) {
      if (_throttlers[this]?.$1.future case Future<R> future) return future;

      final cp = Completer<R>()..complete(this(a, b));
      _throttlers[this] = (cp, Timer(duration, () => _throttlers.remove(this)));

      return cp.future;
    };
  }
}
