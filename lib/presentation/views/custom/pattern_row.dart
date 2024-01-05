import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/pattern_info.dart';

class PatternRow extends StatelessWidget {
  const PatternRow({
    super.key,
    required this.info,
    this.onDelete,
  });

  final PatternInfo info;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    // final theme = FluentTheme.of(context);
    return Tooltip(
      message: info.patternStr,
      displayHorizontally: true,
      useMousePosition: false,
      style: const TooltipThemeData(preferBelow: true),
      child: Text(info.name),
    );
  }
}
