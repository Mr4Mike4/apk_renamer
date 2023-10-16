import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../localizations.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    this.title,
    this.content,
    this.btnYes,
  }) : super(key: key);

  final String? title;
  final String? content;
  final String? btnYes;

  @override
  Widget build(BuildContext context) {
    final S = AppLocal.of(context);
    return ContentDialog(
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [
        FilledButton(
          child: Text(btnYes ?? S.btn_close),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
