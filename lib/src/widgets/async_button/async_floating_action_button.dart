// ignore_for_file: avoid_dynamic_calls, unnecessary_cast

import 'package:flutter/material.dart';

import '../../configs/async_config.dart';
import '../async/async.dart';
import 'async_button.dart';

/// Async version of [FloatingActionButton].
class AsyncFloatingActionButton extends FloatingActionButton {
  /// Creates an async [FloatingActionButton].
  const AsyncFloatingActionButton({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.tooltip,
    super.foregroundColor,
    super.backgroundColor,
    super.focusColor,
    super.hoverColor,
    super.splashColor,
    super.heroTag,
    super.elevation,
    super.focusElevation,
    super.hoverElevation,
    super.highlightElevation,
    super.disabledElevation,
    super.mouseCursor,
    super.mini,
    super.shape,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.materialTapTargetSize,
    super.isExtended,
    super.enableFeedback,
    super.child,
  }) : _type = _FloatingActionButtonType.regular,
       _label = null;

  /// Creates an async [FloatingActionButton.small].
  const AsyncFloatingActionButton.small({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.tooltip,
    super.foregroundColor,
    super.backgroundColor,
    super.focusColor,
    super.hoverColor,
    super.splashColor,
    super.heroTag,
    super.elevation,
    super.focusElevation,
    super.hoverElevation,
    super.highlightElevation,
    super.disabledElevation,
    super.mouseCursor,
    super.shape,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.materialTapTargetSize,
    super.enableFeedback,
    super.child,
  }) : _type = _FloatingActionButtonType.small,
       _label = null,
       super.small();

  /// Creates an async [FloatingActionButton.large].
  const AsyncFloatingActionButton.large({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    super.tooltip,
    super.foregroundColor,
    super.backgroundColor,
    super.focusColor,
    super.hoverColor,
    super.splashColor,
    super.heroTag,
    super.elevation,
    super.focusElevation,
    super.hoverElevation,
    super.highlightElevation,
    super.disabledElevation,
    super.mouseCursor,
    super.shape,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.materialTapTargetSize,
    super.enableFeedback,
    super.child,
  }) : _type = _FloatingActionButtonType.large,
       _label = null,
       super.large();

  /// Creates an async [FloatingActionButton.extended].
  const AsyncFloatingActionButton.extended({
    super.key,
    this.config = const AsyncButtonConfig(),
    required super.onPressed,
    required super.label,
    super.icon,
    super.tooltip,
    super.foregroundColor,
    super.backgroundColor,
    super.focusColor,
    super.hoverColor,
    super.heroTag,
    super.elevation,
    super.focusElevation,
    super.hoverElevation,
    super.splashColor,
    super.highlightElevation,
    super.disabledElevation,
    super.mouseCursor,
    super.shape,
    super.isExtended,
    super.materialTapTargetSize,
    super.clipBehavior,
    super.focusNode,
    super.autofocus,
    super.extendedIconLabelSpacing,
    super.extendedPadding,
    super.extendedTextStyle,
    super.enableFeedback,
  }) : _type = _FloatingActionButtonType.extended,
       _label = label,
       super.extended();

  /// The config for this [AsyncFloatingActionButton].
  final AsyncButtonConfig config;

  @override
  Widget build(BuildContext context) {
    return (this as FloatingActionButton).asAsync(config: config);
  }

  final _FloatingActionButtonType _type;
  final Widget? _label;
}

enum _FloatingActionButtonType { regular, small, large, extended }

// ignore: library_private_types_in_public_api, public_member_api_docs
extension AsyncFabDuplicateExtension on AsyncFloatingActionButton {
  /// Unnecessary duplicate of [asAsync]. Remove this.
  @Deprecated('DUPLICATE, this widget is already asAsync, remove one.')
  Widget asAsync() => this;
}

///
extension AsyncFloatingActionButtonExtension on FloatingActionButton {
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
    bool? keepWidth,
    bool? animateSize,
    AnimatedSizeConfig? animatedSizeConfig,
    Duration? errorDuration,
    Duration? successDuration,
    Duration? styleDuration,
    Curve? styleCurve,
  }) {
    return _FabVisitor(
      fab: this,
      builder: (fab) {
        return AsyncButton(
          tag: 'FloatingActionButton.${fab.type?.name}'.replaceFirst(
            '.regular',
            '',
          ),
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
          configurator: (ctx) => Async.of(ctx).floatingActionButtonConfig,
          onPressed: onPressed,
          child: fab.resolvedChild,
          builder: (context, state, child) {
            if (fab.isExtended) {
              return FloatingActionButton.extended(
                key: key,
                icon: child, //
                label: fab.label!, //
                onPressed: state.onPressed, //
                isExtended: false, // `fab.resolvedChild` replicates this
                clipBehavior: Clip.values[clipBehavior.index.clamp(1, 9)], //
                mouseCursor: mouseCursor,
                shape: shape,
                focusColor: focusColor,
                hoverColor: hoverColor,
                splashColor: splashColor,
                disabledElevation: disabledElevation,
                focusElevation: focusElevation,
                hoverElevation: hoverElevation,
                highlightElevation: highlightElevation,
                autofocus: autofocus,
                materialTapTargetSize: materialTapTargetSize,
                enableFeedback: enableFeedback,
                tooltip: tooltip,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                elevation: elevation,
                focusNode: focusNode,
                heroTag: heroTag,
                extendedIconLabelSpacing: extendedIconLabelSpacing,
                extendedPadding: extendedPadding,
                extendedTextStyle: extendedTextStyle,
              );
            }
            final button = () {
              if (fab.isSmall) return FloatingActionButton.small;
              if (fab.isLarge) return FloatingActionButton.large;
              return FloatingActionButton.new;
            }();

            return button(
              // mods
              child: child,
              onPressed: state.onPressed,

              // props
              key: key,
              mouseCursor: mouseCursor,
              shape: shape,
              clipBehavior: clipBehavior,
              focusColor: focusColor,
              hoverColor: hoverColor,
              splashColor: splashColor,
              disabledElevation: disabledElevation,
              focusElevation: focusElevation,
              hoverElevation: hoverElevation,
              highlightElevation: highlightElevation,
              autofocus: autofocus,
              materialTapTargetSize: materialTapTargetSize,
              enableFeedback: enableFeedback,
              tooltip: tooltip,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              elevation: elevation,
              focusNode: focusNode,
              heroTag: heroTag,
            );
          },
        );
      },
    );
  }
}

class _FabVisitor extends StatefulWidget {
  const _FabVisitor({required this.fab, required this.builder});
  final FloatingActionButton fab;
  final Widget Function(_FabVisitorState state) builder;

  @override
  State<_FabVisitor> createState() => _FabVisitorState();
}

class _FabVisitorState extends State<_FabVisitor> {
  _FloatingActionButtonType? type;
  Widget? label;

  FloatingActionButtonThemeData get theme =>
      Theme.of(context).floatingActionButtonTheme;

  BoxConstraints get _constraints =>
      theme.largeSizeConstraints ??
      const BoxConstraints.tightFor(width: 96, height: 96);

  bool get isExtended => type == _FloatingActionButtonType.extended;
  bool get isSmall => type == _FloatingActionButtonType.small;
  bool get isLarge => type == _FloatingActionButtonType.large;

  /// Replicates the extended fab layout as of [FloatingActionButton.build]
  Widget get resolvedChild {
    final child = widget.fab.child;
    final spacing =
        widget.fab.extendedIconLabelSpacing ??
        theme.extendedIconLabelSpacing ??
        8.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (child != null) child,
        if (child != null && isExtended) SizedBox(width: spacing),
        if (isExtended) label!,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    setType();
  }

  @override
  void didUpdateWidget(covariant _FabVisitor oldWidget) {
    if (oldWidget.fab != widget.fab) {
      setType();
    }
    super.didUpdateWidget(oldWidget);
  }

  void setType() {
    final fab = widget.fab;

    if (fab is AsyncFloatingActionButton) {
      type = fab._type;
      label = fab._label;
    } else {
      type = null;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.visitChildElements(visit),
      );
    }
  }

  void visit(Element element) {
    if (!mounted) return;

    if (element.widget is! RawMaterialButton) {
      return element.visitChildren(visit);
    }
    final raw = element.widget as RawMaterialButton;
    try {
      final row = (raw.child as dynamic).child.child as Row;
      label = row.children.last;
    } catch (_) {}

    if (label != null) {
      type = _FloatingActionButtonType.extended;
    } else if (widget.fab.mini) {
      type = _FloatingActionButtonType.small;
    } else if (_constraints == raw.constraints) {
      type = _FloatingActionButtonType.large;
    } else {
      type = _FloatingActionButtonType.regular;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return type == null ? widget.fab : widget.builder(this);
  }
}
