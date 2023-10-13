import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../localizations.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title,
    this.content,
    this.btnYes,
    this.btnCancel,
  }) : super(key: key);

  final String? title;
  final String? content;
  final String? btnYes;
  final String? btnCancel;

  @override
  Widget build(BuildContext context) {
    final S = AppLocal.of(context);
    return ContentDialog(
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [
        FilledButton(
          child: Text(btnYes ?? S.btn_yes),
          onPressed: () {
            context.pop(true);
          },
        ),
        Button(
          child: Text(btnCancel ?? S.btn_cancel),
          onPressed: () {
            context.pop(false);
          },
        ),
      ],
    );
  }
}
