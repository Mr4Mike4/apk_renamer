import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/template_info.dart';

class TemplateRow extends StatelessWidget {
  const TemplateRow({
    super.key,
    required this.info,
    this.onDelete,
  });

  final TemplateInfo info;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    // final theme = FluentTheme.of(context);
    return Tooltip(
      message: info.templateStr,
      displayHorizontally: true,
      useMousePosition: false,
      style: const TooltipThemeData(preferBelow: true),
      child: Text(info.name),
    );
  }
}
