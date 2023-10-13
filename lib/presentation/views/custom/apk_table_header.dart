import 'package:fluent_ui/fluent_ui.dart';

class ApkTableHeader extends StatelessWidget {
  const ApkTableHeader({
    super.key,
    required this.currentFileName,
    required this.newFileName,
  });

  final String currentFileName;
  final String newFileName;

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.resources.controlStrokeColorDefault,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 64,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              currentFileName,
              style: theme.typography.bodyStrong,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              newFileName,
              style: theme.typography.bodyStrong,
            ),
          ),
          const SizedBox(
            width: 64,
          ),
        ],
      ),
    );
  }
}
