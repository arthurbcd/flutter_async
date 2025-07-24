import 'package:flutter/material.dart';

import '../../configs/async_config.dart';
import '../async/async.dart';
import 'async_button.dart';

/// Async version of [ElevatedButton].
class AsyncElevatedButton extends ElevatedButton with _AsyncMixin {
  /// Creates an async version of [ElevatedButton].
  const AsyncElevatedButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
  });

  /// Creates an async version of [ElevatedButton.icon].
  AsyncElevatedButton.icon({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child:
             ElevatedButton.icon(
               onPressed: onPressed,
               icon: icon,
               label: label,
             ).child,
       );

  @override
  final AsyncButtonConfig config;
}

/// Async version of [OutlinedButton].
class AsyncOutlinedButton extends OutlinedButton with _AsyncMixin {
  /// Creates an async version of [OutlinedButton].
  const AsyncOutlinedButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
  });

  /// Creates an async version of [OutlinedButton.icon].
  AsyncOutlinedButton.icon({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child:
             OutlinedButton.icon(
               onPressed: onPressed,
               icon: icon,
               label: label,
             ).child,
       );

  @override
  final AsyncButtonConfig config;
}

/// Async version of [TextButton].
class AsyncTextButton extends TextButton with _AsyncMixin {
  /// Creates an async version of [TextButton].
  const AsyncTextButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
    super.isSemanticButton = true,
  });

  /// Creates an async version of [TextButton.icon].
  AsyncTextButton.icon({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
    super.isSemanticButton = true,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child:
             TextButton.icon(
               onPressed: onPressed,
               icon: icon,
               label: label,
             ).child!,
       );

  @override
  final AsyncButtonConfig config;
}

/// Async version of [FilledButton].
class AsyncFilledButton extends FilledButton with _AsyncMixin {
  /// Creates an async version of [FilledButton].
  const AsyncFilledButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
  });

  /// Creates an async version of [FilledButton.tonal].
  const AsyncFilledButton.tonal({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.autofocus,
    super.clipBehavior,
    super.statesController,
    required super.child,
  }) : super.tonal();

  /// Creates an async version of [FilledButton.icon].
  AsyncFilledButton.icon({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super(
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child:
             FilledButton.icon(
               onPressed: onPressed,
               icon: icon,
               label: label,
             ).child,
       );

  /// Creates an async version of [FilledButton.tonalIcon].
  AsyncFilledButton.tonalIcon({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    super.statesController,
    required Widget icon,
    required Widget label,
  }) : super.tonal(
         // same variant as FilledButton.tonal
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child:
             FilledButton.tonalIcon(
               onPressed: onPressed,
               icon: icon,
               label: label,
             ).child,
       );

  @override
  final AsyncButtonConfig config;
}

mixin _AsyncMixin on ButtonStyleButton {
  /// The async config of this [ButtonStyleButton].
  AsyncButtonConfig get config;

  @override
  State<ButtonStyleButton> createState() => _AsyncState();
}

class _AsyncState extends State<_AsyncMixin> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_cast
    return (widget as ButtonStyleButton).asAsync(config: widget.config);
  }
}

/// Extension for [ButtonStyleButton] to be used as an async button.
extension AsyncButtonExtension on ButtonStyleButton {
  /// Returns the async version of this [FloatingActionButton].
  ///
  /// - If [config] is set, all other parameters are ignored.
  /// - If any icon is set, the respective builder is ignored.
  /// - If any color is set, the respective theme is ignored.
  Widget asAsync({
    AsyncButtonConfig? config,
    Widget? loadingIcon,
    Widget? errorIcon,
    Widget? successIcon,
    WidgetBuilder? loadingBuilder,
    ErrorBuilder? errorBuilder,
    WidgetBuilder? successBuilder,
    Color? loadingColor,
    Color? errorColor,
    Color? successColor,
    AsyncThemeGetter? loadingTheme,
    AsyncThemeGetter? errorTheme,
    AsyncThemeGetter? successTheme,
    bool? keepHeight,
    bool? keepWidth,
    bool? animateSize,
    AnimatedSizeConfig? animatedSizeConfig,
    Duration? errorDuration,
    Duration? successDuration,
    Duration? styleDuration,
    Curve? styleCurve,
  }) {
    return Builder(
      builder: (context) {
        var tag = switch (this) {
          TextButton() => 'TextButton',
          OutlinedButton() => 'OutlinedButton',
          ElevatedButton() => 'ElevatedButton',
          FilledButton() when isTonal(context) => 'FilledButton.tonal',
          FilledButton() => 'FilledButton',
          _ => throw UnimplementedError('Unknown ButtonStyleButton'),
        };
        if (runtimeType.toString().endsWith('Icon')) {
          tag.contains('.') ? tag += 'Icon' : tag += '.icon';
        }
        return AsyncButton(
          tag: tag,
          config:
              config ??
              AsyncButtonConfig.icon(
                successIcon: successIcon,
                loadingIcon: loadingIcon,
                errorIcon: errorIcon,
                successColor: successColor,
                loadingColor: loadingColor,
                errorColor: errorColor,
              ).copyWith(
                successBuilder: successBuilder,
                loadingBuilder: loadingBuilder,
                errorBuilder: errorBuilder,
                keepHeight: keepHeight,
                keepWidth: keepWidth,
                animateSize: animateSize,
                animatedSizeConfig: animatedSizeConfig,
                errorDuration: errorDuration,
                successDuration: successDuration,
                styleDuration: styleDuration,
                styleCurve: styleCurve,
                errorTheme: errorTheme,
                loadingTheme: loadingTheme,
                successTheme: successTheme,
              ),
          configurator: (context) {
            final config = Async.of(context);
            if (this is TextButton) return config.textButtonConfig;
            if (this is OutlinedButton) return config.outlinedButtonConfig;
            if (this is ElevatedButton) return config.elevatedButtonConfig;
            if (this is FilledButton) return config.filledButtonConfig;
            return null;
          },
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: child ?? const Text(''),
          builder: (context, state, child) {
            final button = switch (this) {
              TextButton() => TextButton.new,
              OutlinedButton() => OutlinedButton.new,
              ElevatedButton() => ElevatedButton.new,
              FilledButton() =>
                isTonal(context) ? FilledButton.tonal : FilledButton.new,
              _ => throw UnimplementedError('Unknown ButtonStyleButton'),
            };

            if (this is TextButton) {
              return TextButton(
                // mods
                onPressed: state.onPressed,
                onLongPress: state.onLongPress,

                // props
                key: key,
                style: style,
                onHover: onHover,
                onFocusChange: onFocusChange,
                focusNode: focusNode,
                autofocus: autofocus,
                clipBehavior: clipBehavior ?? Clip.hardEdge,
                statesController: statesController,
                isSemanticButton: isSemanticButton,
                child: child,
              );
            }

            return button(
              // mods
              onPressed: state.onPressed,
              onLongPress: state.onLongPress,

              // props
              key: key,
              style: style,
              onHover: onHover,
              onFocusChange: onFocusChange,
              focusNode: focusNode,
              autofocus: autofocus,
              clipBehavior: clipBehavior ?? Clip.hardEdge,
              statesController: statesController,
              child: child,
            );
          },
        );
      },
    );
  }
}

// ignore: library_private_types_in_public_api, public_member_api_docs
extension AsyncButtonDuplicateExtension on _AsyncMixin {
  /// Unnecessary duplicate of [asAsync]. Remove this.
  @Deprecated('DUPLICATE, this widget is already asAsync, remove one.')
  Widget asAsync() => this;
}

extension on ButtonStyleButton {
  bool isTonal(BuildContext context) {
    const tonal = FilledButton.tonal(onPressed: null, child: null);

    // ignore: invalid_use_of_protected_member
    final a = defaultStyleOf(context);
    final b = tonal.defaultStyleOf(context);

    final isTonal = [
      a.textStyle?.base == b.textStyle?.base,
      a.backgroundColor?.base == b.backgroundColor?.base,
      a.foregroundColor?.base == b.foregroundColor?.base,
      a.overlayColor?.base == b.overlayColor?.base,
      a.shadowColor?.base == b.shadowColor?.base,
      a.surfaceTintColor?.base == b.surfaceTintColor?.base,
      a.elevation?.base == b.elevation?.base,
      a.minimumSize?.base == b.minimumSize?.base,
      a.maximumSize?.base == b.maximumSize?.base,
      a.shape?.base == b.shape?.base,
      a.mouseCursor?.base == b.mouseCursor?.base,
      a.visualDensity == b.visualDensity,
      a.tapTargetSize == b.tapTargetSize,
      a.splashFactory == b.splashFactory,
      // padding is the only difference between tonal and tonalIcon
      // a.padding?.base == b.padding?.base,
    ].every((isTrue) => isTrue);

    return isTonal;
  }
}

// ignore: deprecated_member_use
extension<T> on MaterialStateProperty<T?> {
  T? get base => resolve({});
}
