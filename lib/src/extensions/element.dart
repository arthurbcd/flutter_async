import 'package:flutter/widgets.dart';

/// A [BuildContext] extension for [Element], [State] and [Widget] visits.
extension ContextElementExtension on BuildContext {
  /// Visits the [Element] tree below this [BuildContext].
  ///
  /// If [onElement], [onState] or [onWidget] returns `false`, the visit will stop.
  void visit({
    bool Function(Element element)? onElement,
    bool Function(Widget widget)? onWidget,
    bool Function(State state)? onState,
  }) {
    if (onElement == null && onState == null && onWidget == null) {
      return;
    }

    void visit(Element e) {
      if (onElement?.call(e) == false) return;
      if (onWidget?.call(e.widget) == false) return;
      if (e is StatefulElement && (onState?.call(e.state) == false)) return;

      e.visitChildren(visit);
    }

    visitChildElements(visit);
  }
}
