// Generated by Dart Safe Data Class Generator. * Change this header on extension settings *
// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars
part of 'async_config.dart';

/// The configuration of `AsyncBuilder`.
@immutable
class AsyncBuilderConfig {
  /// Creates a new [AsyncBuilderConfig].
  const AsyncBuilderConfig({
    this.errorBuilder,
    this.loadingBuilder,
    this.reloadingBuilder,
    this.noneBuilder,
  });

  /// Overrides [AsyncConfig.errorBuilder].
  final ErrorBuilder? errorBuilder;

  /// Overrides [AsyncConfig.loadingBuilder].
  final WidgetBuilder? loadingBuilder;

  /// Overrides [AsyncConfig.reloadingBuilder].
  final WidgetBuilder? reloadingBuilder;

  /// Overrides [AsyncConfig.noneBuilder].
  final WidgetBuilder? noneBuilder;

  /// Copies this [AsyncBuilderConfig] with the given fields replaced with the new values.
  AsyncBuilderConfig copyWith({
    ErrorBuilder? errorBuilder,
    WidgetBuilder? loadingBuilder,
    WidgetBuilder? reloadingBuilder,
    WidgetBuilder? noneBuilder,
  }) {
    return AsyncBuilderConfig(
      errorBuilder: errorBuilder ?? this.errorBuilder,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
      reloadingBuilder: reloadingBuilder ?? this.reloadingBuilder,
      noneBuilder: noneBuilder ?? this.noneBuilder,
    );
  }
}
