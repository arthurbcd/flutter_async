// Generated by Dart Safe Data Class Generator. * Change this header on extension settings *
// ignore_for_file: avoid_dynamic_calls, lines_longer_than_80_chars
part of 'async_config.dart';

/// The configuration of `AsyncButton`.
class AsyncButtonConfig {
  /// Creates a new [AsyncButtonConfig].
  const AsyncButtonConfig({
    this.keepHeight,
    this.keepWidth,
    this.animateSize,
    this.animatedSizeConfig,
    this.errorDuration,
    this.styleDuration,
    this.styleCurve,
    this.loadingBuilder,
    this.errorBuilder,
  });

  /// Whether to keep button height on state changes. Defaults to `true`.
  final bool? keepHeight;

  /// Whether to keep button width on state changes. Defaults to `false`.
  final bool? keepWidth;

  /// Whether this button should animate its size.
  final bool? animateSize;

  /// The configuration for [AnimatedSize].
  final AnimatedSizeConfig? animatedSizeConfig;

  /// The duration to show error widget.
  final Duration? errorDuration;

  /// The duration between styles animations.
  final Duration? styleDuration;

  /// The curve to use on styles animations.
  final Curve? styleCurve;

  /// The widget to show on loading.
  final WidgetBuilder? loadingBuilder;

  /// The widget to show on error.
  final ErrorBuilder? errorBuilder;
}

/// Configuration for [AnimatedSize].
class AnimatedSizeConfig {
  /// Creates a new [AnimatedSizeConfig]
  ///
  /// This class will fill [AnimatedSize] parameters in an `AsyncButton`
  const AnimatedSizeConfig({
    this.alignment = Alignment.center,
    this.curve = Curves.fastOutSlowIn,
    this.duration = const Duration(milliseconds: 600),
    this.reverseDuration,
    this.clipBehavior = Clip.none,
  });

  /// The [AnimatedSize] alignment.
  final Alignment alignment;

  /// The [AnimatedSize] curve.
  final Curve curve;

  /// The [AnimatedSize] duration.
  final Duration duration;

  /// The [AnimatedSize] reverse duration.
  final Duration? reverseDuration;

  /// The [AnimatedSize] clip behavior.
  final Clip clipBehavior;
}

/// The resolved config of `AsyncButton`.
@immutable
class AsyncButtonResolvedConfig implements AsyncButtonConfig {
  /// Creates a [AsyncButtonConfig] with default values.
  const AsyncButtonResolvedConfig({
    this.keepHeight = true,
    this.keepWidth = false,
    this.animateSize = true,
    this.animatedSizeConfig = const AnimatedSizeConfig(),
    this.errorDuration = const Duration(seconds: 3),
    this.styleCurve = Curves.easeInOut,
    this.styleDuration = const Duration(milliseconds: 300),
    this.errorBuilder = Async.errorBuilder,
    this.loadingBuilder = Async.loadingBuilder,
  });

  @override
  final bool keepHeight;

  @override
  final bool keepWidth;

  @override
  final bool animateSize;

  @override
  final AnimatedSizeConfig animatedSizeConfig;

  @override
  final Duration errorDuration;

  @override
  final Curve styleCurve;

  @override
  final Duration styleDuration;

  @override
  final ErrorBuilder errorBuilder;

  @override
  final WidgetBuilder loadingBuilder;
}

///
extension AsyncButtonConfigExtension on AsyncButtonConfig {
  /// Copies this [AsyncButtonConfig] with the given fields replaced with the new values.
  AsyncButtonConfig copyWith({
    bool? keepHeight,
    bool? keepWidth,
    AnimatedSizeConfig? animatedSizeConfig,
    Duration? errorDuration,
    Duration? styleDuration,
    Curve? styleCurve,
    WidgetBuilder? loadingBuilder,
    ErrorBuilder? errorBuilder,
  }) {
    return AsyncButtonConfig(
      keepHeight: keepHeight ?? this.keepHeight,
      keepWidth: keepWidth ?? this.keepWidth,
      animatedSizeConfig: animatedSizeConfig ?? this.animatedSizeConfig,
      errorDuration: errorDuration ?? this.errorDuration,
      styleDuration: styleDuration ?? this.styleDuration,
      styleCurve: styleCurve ?? this.styleCurve,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
      errorBuilder: errorBuilder ?? this.errorBuilder,
    );
  }

  /// Merges this [AsyncButtonConfig] with the given [AsyncButtonConfig].
  AsyncButtonConfig merge(AsyncButtonConfig? other) {
    if (other == null) return this;
    return copyWith(
      keepHeight: keepHeight ?? other.keepHeight,
      keepWidth: keepWidth ?? other.keepWidth,
      animatedSizeConfig: animatedSizeConfig ?? other.animatedSizeConfig,
      errorDuration: errorDuration ?? other.errorDuration,
      styleDuration: styleDuration ?? other.styleDuration,
      styleCurve: styleCurve ?? other.styleCurve,
      loadingBuilder: loadingBuilder ?? other.loadingBuilder,
      errorBuilder: errorBuilder ?? other.errorBuilder,
    );
  }

  /// Creates a [AsyncButtonResolvedConfig] from this [AsyncButtonConfig].
  AsyncButtonResolvedConfig resolve() {
    const def = AsyncButtonResolvedConfig();

    return AsyncButtonResolvedConfig(
      keepHeight: keepHeight ?? def.keepHeight,
      keepWidth: keepWidth ?? def.keepWidth,
      animatedSizeConfig: animatedSizeConfig ?? def.animatedSizeConfig,
      errorDuration: errorDuration ?? def.errorDuration,
      styleCurve: styleCurve ?? def.styleCurve,
      styleDuration: styleDuration ?? def.styleDuration,
      errorBuilder: errorBuilder ?? def.errorBuilder,
      loadingBuilder: loadingBuilder ?? def.loadingBuilder,
    );
  }
}