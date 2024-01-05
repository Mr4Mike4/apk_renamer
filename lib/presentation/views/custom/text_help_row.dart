import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/tag_info.dart';

class TextHelpRow extends StatelessWidget {
  const TextHelpRow({
    super.key,
    required this.info,
    this.tagWidth,
  });

  final TagInfo info;
  final double? tagWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            color: theme.selectionColor,
            // boxShadow: [
            //   BoxShadow(
            //     offset: const Offset(0, 3),
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 3,
            //     blurRadius: 3,
            //   ),
            // ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          width: tagWidth,
          child: Text(
            info.tag,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.resources.textFillColorInverse,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            info.text,
            softWrap: false,
          ),
        ),
      ],
    );
  }
}