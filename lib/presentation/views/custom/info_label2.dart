import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class InfoLabel2 extends StatelessWidget {
  /// Creates an info label.
  InfoLabel2({
    super.key,
    this.child,
    required String label,
    TextStyle? labelStyle,
    this.isHeader = true,
    this.tooltip,
  }) : label = TextSpan(text: label, style: labelStyle);

  /// Creates an info label.
  const InfoLabel2.rich({
    super.key,
    this.child,
    required this.label,
    this.isHeader = true, this.tooltip,
  });

  final InlineSpan label;
  final String? tooltip;

  /// The widget to apply the label.
  final Widget? child;

  /// Whether to render the [label] above [child] or on its side.
  final bool isHeader;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<InlineSpan>('label', label))
      ..add(FlagProperty('isHeader', value: isHeader, ifFalse: 'isSide'));
  }

  @override
  Widget build(BuildContext context) {
    Widget labelWidget = Text.rich(
      label,
      style: FluentTheme.maybeOf(context)?.typography.body,
    );
    if(tooltip != null){
      labelWidget = Tooltip(
        message: tooltip,
        displayHorizontally: true,
        useMousePosition: false,
        style: const TooltipThemeData(preferBelow: true),
        child: labelWidget,
      );
    }
    return Flex(
      direction: isHeader ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
      isHeader ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (isHeader)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4.0),
            child: labelWidget,
          ),
        if (child != null) Flexible(child: child!),
        if (!isHeader)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4.0),
            child: labelWidget,
          ),
      ],
    );
  }
}