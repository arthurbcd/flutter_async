import 'package:flutter/material.dart';

import '../../configs/async_config.dart';
import '../../extensions/element.dart';
import '../async/async.dart';
import 'async_button.dart';

/// Async version of [FloatingActionButton].
class AsyncIconButton extends IconButton {
  /// Creates an async [IconButton].
  const AsyncIconButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    required super.onPressed,
    super.mouseCursor,
    super.focusNode,
    super.autofocus = false,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    required super.icon,
    super.onHover,
    super.onLongPress,
  });

  /// Creates an async [IconButton.filled].
  const AsyncIconButton.filled({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    required super.onPressed,
    super.mouseCursor,
    super.focusNode,
    super.autofocus = false,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    required super.icon,
    super.onHover,
    super.onLongPress,
  }) : super.filled();

  /// Creates an async [IconButton.filledTonal].
  const AsyncIconButton.filledTonal({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    required super.onPressed,
    super.mouseCursor,
    super.focusNode,
    super.autofocus = false,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    required super.icon,
    super.onHover,
    super.onLongPress,
  }) : super.filledTonal();

  /// Creates an async [IconButton.outlined].
  const AsyncIconButton.outlined({
    super.key,
    this.config = const AsyncButtonConfig(),
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    required super.onPressed,
    super.mouseCursor,
    super.focusNode,
    super.autofocus = false,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    required super.icon,
    super.onHover,
    super.onLongPress,
  }) : super.outlined();

  /// The config for this [AsyncIconButton].
  final AsyncButtonConfig config;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_cast
    return (this as IconButton).asAsync(config: config);
  }
}

// ignore: library_private_types_in_public_api, public_member_api_docs
extension AsyncIconButtonDuplicateExtension on AsyncIconButton {
  /// Unnecessary duplicate of [asAsync]. Remove this.
  @Deprecated('DUPLICATE, this widget is already asAsync, remove one.')
  Widget asAsync() => this;
}

///
extension AsyncIconButtonExtension on IconButton {
  /// Returns the async version of this [FloatingActionButton].
  ///
  /// - If [config] is set, all other parameters are ignored.
  /// - If any icon widget is set, the respective builder is ignored.
  /// - If any seed color is set, the respective theme is ignored.
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
    bool? keepWidth = true,
    bool? animateSize,
    AnimatedSizeConfig? animatedSizeConfig,
    Duration? errorDuration,
    Duration? successDuration,
    Duration? styleDuration,
    Curve? styleCurve,
  }) {
    return _IconButtonVisitor(
      builder: (variant) {
        if (variant == null) return this;

        return AsyncButton(
          tag: switch (variant) {
            _IconButtonVariant.standard => 'IconButton',
            _IconButtonVariant.filled => 'IconButton.filled',
            _IconButtonVariant.filledTonal => 'IconButton.filledTonal',
            _IconButtonVariant.outlined => 'IconButton.outlined',
          },
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
          configurator: (context) => Async.of(context).iconButtonConfig,
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: icon,
          builder: (context, state, child) {
            final button = switch (variant) {
              _IconButtonVariant.standard => IconButton.new,
              _IconButtonVariant.filled => IconButton.filled,
              _IconButtonVariant.filledTonal => IconButton.filledTonal,
              _IconButtonVariant.outlined => IconButton.outlined,
            };

            return button(
              // mods
              onPressed: state.onPressed,
              onLongPress: state.onLongPress,
              icon: child,

              // props
              key: key,
              iconSize: iconSize,
              visualDensity: visualDensity,
              padding: padding,
              alignment: alignment,
              splashRadius: splashRadius,
              color: color,
              focusColor: focusColor,
              hoverColor: hoverColor,
              highlightColor: highlightColor,
              splashColor: splashColor,
              disabledColor: disabledColor,
              mouseCursor: mouseCursor,
              focusNode: focusNode,
              autofocus: autofocus,
              tooltip: tooltip,
              enableFeedback: enableFeedback,
              constraints: constraints,
              style: style,
              isSelected: isSelected,
              selectedIcon: selectedIcon,
              onHover: onHover,
            );
          },
        );
      },
    );
  }
}

class _IconButtonVisitor extends StatefulWidget {
  const _IconButtonVisitor({required this.builder});
  final Widget Function(_IconButtonVariant? variant) builder;

  @override
  State<_IconButtonVisitor> createState() => _IconButtonVisitorState();
}

class _IconButtonVisitorState extends State<_IconButtonVisitor> {
  _IconButtonVariant? variant;

  void setVariant(dynamic widget) {
    // ignore: avoid_dynamic_calls
    final index = (widget as dynamic).variant.index as int;
    variant = _IconButtonVariant.values[index];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.visit(
        onWidget: (widget) {
          if (widget is ButtonStyleButton) setVariant(widget);
          return widget is! ButtonStyleButton;
        },
      );
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(variant);
}

enum _IconButtonVariant { standard, filled, filledTonal, outlined }
