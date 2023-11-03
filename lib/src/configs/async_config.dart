// Generated by Dart Safe Data Class Generator. * Change this header on extension settings *
// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars
import 'package:flutter/material.dart';

import '../widgets/async/async.dart';

part 'async_builder_config.dart';
part 'async_button_config.dart';

/// The entire configuration of `flutter_async`, holded by [Async].
@immutable
class AsyncConfig {
  /// Creates a new [AsyncConfig].
  ///
  /// Specific configs are always prioritized over general ones.
  const AsyncConfig({
    this.noneBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.reloadingBuilder,
    this.builderConfig,
    this.buttonConfig,
    this.textButtonConfig,
    this.filledButtonConfig,
    this.elevatedButtonConfig,
    this.outlinedButtonConfig,
  });

  /// The general [WidgetBuilder] for none state.
  final WidgetBuilder? noneBuilder;

  /// The general [ErrorBuilder] for error state.
  final ErrorBuilder? errorBuilder;

  /// The general [WidgetBuilder] for loading state.
  final WidgetBuilder? loadingBuilder;

  /// The general [WidgetBuilder] for reloading state.
  final WidgetBuilder? reloadingBuilder;

  /// The config for `AsyncBuilder`. Overrides general builders.
  final AsyncBuilderConfig? builderConfig;

  /// The config for `AsyncButton`. Overrides general builders.
  final AsyncButtonConfig? buttonConfig;

  /// The config for `AsyncTextButton`. Overrides [buttonConfig].
  final AsyncButtonConfig? textButtonConfig;

  /// The config for `AsyncFilledButton`. Overrides [buttonConfig].
  final AsyncButtonConfig? filledButtonConfig;

  /// The config for `AsyncElevatedButton`. Overrides [buttonConfig].
  final AsyncButtonConfig? elevatedButtonConfig;

  /// The config for `AsyncOutlinedButton`. Overrides [buttonConfig].
  final AsyncButtonConfig? outlinedButtonConfig;

  /// Copies this [AsyncConfig] with the given fields replaced with the new values.
  AsyncConfig copyWith({
    WidgetBuilder? noneBuilder,
    ErrorBuilder? errorBuilder,
    WidgetBuilder? loadingBuilder,
    WidgetBuilder? reloadingBuilder,
    AsyncBuilderConfig? builderConfig,
    AsyncButtonConfig? buttonConfig,
    AsyncButtonConfig? elevatedButtonConfig,
    AsyncButtonConfig? filledButtonConfig,
    AsyncButtonConfig? textButtonConfig,
    AsyncButtonConfig? outlinedButtonConfig,
  }) {
    return AsyncConfig(
      noneBuilder: noneBuilder ?? this.noneBuilder,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
      reloadingBuilder: reloadingBuilder ?? this.reloadingBuilder,
      builderConfig: builderConfig ?? this.builderConfig,
      buttonConfig: buttonConfig ?? this.buttonConfig,
      textButtonConfig: textButtonConfig ?? this.textButtonConfig,
      filledButtonConfig: filledButtonConfig ?? this.filledButtonConfig,
      elevatedButtonConfig: elevatedButtonConfig ?? this.elevatedButtonConfig,
      outlinedButtonConfig: outlinedButtonConfig ?? this.outlinedButtonConfig,
    );
  }

  /// Merges this [AsyncConfig] with the given [AsyncConfig].
  AsyncConfig merge(AsyncConfig? other) {
    if (other == null) return this;
    return copyWith(
      errorBuilder: errorBuilder ?? other.errorBuilder,
      noneBuilder: noneBuilder ?? other.noneBuilder,
      loadingBuilder: loadingBuilder ?? other.loadingBuilder,
      reloadingBuilder: reloadingBuilder ?? other.reloadingBuilder,
      builderConfig: builderConfig ?? other.builderConfig,
      buttonConfig: buttonConfig ?? other.buttonConfig,
      textButtonConfig: textButtonConfig ?? other.textButtonConfig,
      filledButtonConfig: filledButtonConfig ?? other.filledButtonConfig,
      elevatedButtonConfig: elevatedButtonConfig ?? other.elevatedButtonConfig,
      outlinedButtonConfig: outlinedButtonConfig ?? other.outlinedButtonConfig,
    );
  }
}
