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
    return SnackBar(content: Text(message));
  };

  /// The default error snackbar to use on [showSnackBar].
  static SnackBarBuilder errorBuilder = (context, message) {
    final theme = Theme.of(context);

    return SnackBar(
      content: Text(message),
      backgroundColor: theme.colorScheme.error,
    );
  };

  /// The default [AnimationStyle] to use on [showSnackBar].
  static AnimationStyle? animationStyle;

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
    context ??= Async.context;
    final messenger = ScaffoldMessenger.of(context);

    return then(
      (value) {
        if (successMessage != null) {
          messenger.showSnackBar(
            successBuilder(context!, successMessage),
            snackBarAnimationStyle: animationStyle,
          );
        }
        return value;
      },
      onError: (Object e, StackTrace s) {
        messenger.showSnackBar(
          errorBuilder(context!, errorMessage ?? Async.message(e)),
          snackBarAnimationStyle: animationStyle,
        );
        Error.throwWithStackTrace(e, s);
      },
    );
  }
}
