// ignore_for_file: use_function_type_syntax_for_parameters

part of 'async_button.dart';

class AsyncButtonState<T extends ButtonStyleButton>
    extends AsyncStyleState<AsyncButton<T>, void, ButtonStyle> {
  /// Resolves the default [AsyncButtonConfig] of this [T].
  AsyncButtonConfig? get _config {
    final config = () {
      if (isFilledButton) return AsyncFilledButton._config;
      if (isOutlinedButton) return AsyncOutlinedButton._config;
      if (isTextButton) return AsyncTextButton._config;
      return AsyncElevatedButton._config;
    }();

    final theme = widget.themeStyleOf(context);
    return config ?? (theme is AsyncButtonStyle ? theme.config : null);
  }

  /// The current [AsyncButtonConfig] of this button.
  AsyncButtonConfig get config =>
      widget.config ?? _config ?? AsyncButton.baseConfig;

  late final errorColor = Theme.of(context).colorScheme.error;

  late final baseStyle =
      (widget.style ?? widget.themeStyleOf(context) ?? const ButtonStyle())
          .merge(widget.defaultStyleOf(context));

  late final errorStyle = baseStyle.copyWith(
    backgroundColor: () {
      if (isOutlinedButton) return null;
      if (isTextButton) return null;
      return MaterialStatePropertyAll(errorColor);
    }(),
    foregroundColor: () {
      if (isElevatedButton) return null;
      if (isFilledButton) return null;
      return MaterialStatePropertyAll(errorColor);
    }(),
  );

  @override
  AsyncStyle<ButtonStyle> get asyncStyle => AsyncStyle(
        baseStyle: baseStyle,
        errorStyle: baseStyle,
        loadingStyle: baseStyle,
        errorDuration: config.errorDuration,
        styleDuration: config.styleDuration,
        styleCurve: config.styleCurve,
        lerp: ButtonStyle.lerp,
      );

  /// The child of this button.
  Widget get child => widget.child!;

  @override
  Future<void> reload() => press(); // default action.

  @override
  Future<void> press() => setAction(widget.onPressed!);

  @override
  Future<void> longPress() => setAction(widget.onLongPress!);

  @override
  Widget build(BuildContext context) {
    Widget animatedSize({required Widget child}) {
      if (config.animatedSize == null) return child;

      return AnimatedSize(
        curve: config.animatedSize!.curve,
        duration: config.animatedSize!.duration,
        alignment: config.animatedSize!.alignment,
        clipBehavior: config.animatedSize!.clipBehavior,
        reverseDuration: config.animatedSize!.reverseDuration,
        child: child,
      );
    }

    // Animated child.
    final child = animatedSize(
      child: () {
        if (hasError && hasSize) return config.error(context, this);
        if (isLoading && hasSize) return config.loader(context, this);
        return widget.child!;
      }(),
    );

    return SizedBox.fromSize(
      size: config.keepSize && hasSize ? size : null,
      child: () {
        if (isOutlinedButton) return OutlinedButton.new;
        if (isTextButton) return TextButton.new;
        if (isFilledButton) return FilledButton.new;
        return ElevatedButton.new;
      }()(
        key: widget.key,
        onPressed: widget.onPressed != null ? press : null,
        onLongPress: widget.onLongPress != null ? longPress : null,
        onHover: widget.onHover,
        onFocusChange: widget.onFocusChange,
        style: animatedStyle ?? baseStyle,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        clipBehavior: widget.clipBehavior,
        statesController: widget.statesController,
        child: child,
      ),
    );
  }
}
