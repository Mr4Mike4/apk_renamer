import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../localizations.dart';
import 'input_text_field.dart';

class TemplateNameDialog extends StatelessWidget {
  TemplateNameDialog({
    super.key,
  });

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final S = AppLocal.of(context);
    return ContentDialog(
      content: SizedBox(
        height: 70,
        child: InputTextField(
          labelText: S.template_name,
          controller: _controller,
        ),
      ),
      actions: [
        FilledButton(
          child: Text(S.btn_save),
          onPressed: () {
            context.pop(_controller.text);
          },
        ),
        Button(
          child: Text(S.btn_cancel),
          onPressed: () {
            context.pop();
          },
        ),
      ],
    );
  }
}
