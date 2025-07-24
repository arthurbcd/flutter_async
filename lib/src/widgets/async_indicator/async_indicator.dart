import 'package:flutter/material.dart';

import '../../utils/adaptive_theme.dart';

/// A smart adaptive [CircularProgressIndicator].
class AsyncIndicator extends CircularProgressIndicator {
  /// A [Widget] that displays a [CircularProgressIndicator] when [visible].
  ///
  /// The color and backgroundColor are automatically resolved based on the
  /// nearest [Theme] ancestor and it's contrast ratio. See [AdaptiveTheme].
  ///
  /// The stroke also linearly depends on the shortest side of the parent.
  ///
  const AsyncIndicator({
    super.key,
    this.visible = true,
    this.sizeRatio = 2 / 3,
    this.minStrokeWidth = 2,
    this.maxStrokeWidth = 4,
    this.maxDimension = 36,
    this.minDimension = 14,
    super.value,
    super.color,
    super.backgroundColor,
    super.valueColor,
    super.strokeAlign = CircularProgressIndicator.strokeAlignCenter,
    super.semanticsLabel,
    super.semanticsValue,
    super.strokeCap,
    super.constraints,
    super.padding,
    super.strokeWidth,
    super.trackGap,
    this.child,
  });

  /// Shows or overlays on [child] a [LinearProgressIndicator] when visible.
  static Widget linear({
    Key? key,
    bool visible = true,
    double? value,
    Color? backgroundColor,
    Color? color,
    Animation<Color?>? valueColor,
    double? minHeight,
    String? semanticsLabel,
    String? semanticsValue,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Widget? child,
  }) {
    final linear = Visibility(
      visible: visible,
      child: const LinearProgressIndicator(),
    );

    if (child == null) return linear;
    return Stack(alignment: Alignment.center, children: [child, linear]);
  }

  /// Whether to show the indicator.
  final bool visible;

  /// The minimum stroke width of the indicator.
  final double minStrokeWidth;

  /// The maximum stroke width of the indicator.
  final double maxStrokeWidth;

  /// The maximum dimension of the indicator.
  final double maxDimension;

  /// The minimum dimension of the indicator.
  final double minDimension;

  /// The size ratio between the indicator and the parent.
  /// Material recommends the fab to have 1/3 or 1/4 of the parent's size.
  ///
  /// The final dimension is clamped between [minDimension] and [maxDimension].
  final double sizeRatio;

  /// An optional child to overlay this [AsyncIndicator].
  final Widget? child;

  @override
  State<AsyncIndicator> createState() => _AsyncIndicatorState();
}

class _AsyncIndicatorState extends State<AsyncIndicator> {
  Size? size;

  void setSize(Size? size) {
    if (this.size == null) {
      setState(() => this.size = size);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setSize(context.size));

    final loader = Visibility(
      visible: widget.visible,
      child: Builder(
        builder: (context) {
          final size = this.size ?? Size.zero;

          // constrain the dimension to maxDimension
          final dimension = (size.shortestSide * widget.sizeRatio).clamp(
            widget.minDimension,
            widget.maxDimension,
          );

          // let maxStrokWidth depend on maxDimension to scale it
          final strokeRatio = widget.maxStrokeWidth / widget.maxDimension;

          // let it scale linearly between min and max stroke width
          final strokeWidth = (dimension * strokeRatio).clamp(
            widget.minStrokeWidth,
            widget.maxStrokeWidth,
          );

          return AdaptiveTheme(
            child: AspectRatio(
              aspectRatio: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox.square(
                  dimension: dimension,
                  child: CircularProgressIndicator(
                    value: widget.value,
                    backgroundColor: widget.backgroundColor,
                    color: widget.color,
                    valueColor: widget.valueColor,
                    strokeWidth: strokeWidth,
                    strokeAlign: widget.strokeAlign,
                    semanticsLabel: widget.semanticsLabel,
                    semanticsValue: widget.semanticsValue,
                    strokeCap: widget.strokeCap,
                    constraints: widget.constraints,
                    padding: widget.padding,
                    trackGap: widget.trackGap,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    var child = widget.child ?? loader;

    if (widget.child != null) {
      child = Stack(alignment: Alignment.center, children: [child, loader]);
    }

    return child;
  }
}
