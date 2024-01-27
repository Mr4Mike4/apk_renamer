import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/tag_info.dart';
import '../../../domain/model/template_info.dart';
import '../../../internal/application.dart';
import '../../../localizations.dart';
import 'input_text_field.dart';
import 'template_row.dart';
import 'text_help_row.dart';

typedef TemplateInfoCallback = void Function(TemplateInfo info);

class TemplateWidget extends StatelessWidget {
  TemplateWidget({
    super.key,
    this.controller,
    this.onSaveTemplate,
    this.dateTimeHelp,
    this.apkHelp,
    this.myTemplates,
    this.onDeleteTemplate,
  });

  final TextEditingController? controller;
  final VoidCallback? onSaveTemplate;
  final TemplateInfoCallback? onDeleteTemplate;
  final List<TagInfo>? dateTimeHelp;
  final List<TagInfo>? apkHelp;
  final List<TemplateInfo>? myTemplates;

  final _menuController = FlyoutController();

  void _setTag(TagInfo info) {
    final value = controller?.value;
    if (value != null) {
      final sel = value.selection;
      final range = TextRange(
        start: sel.start,
        end: sel.end,
      );
      // logger.d('_setTag');
      controller?.value = value.replaced(range, info.tag);
    }
  }

  void _onSelectTemplate(TemplateInfo info) {
    controller?.text = info.templateStr;
  }

  void _showMenu() {
    _menuController.showFlyout(
      autoModeConfiguration: FlyoutAutoConfiguration(
        preferredMode: FlyoutPlacementMode.left,
      ),
      barrierDismissible: true,
      dismissOnPointerMoveAway: false,
      dismissWithEsc: true,
      navigatorKey: rootNavigatorKey.currentState,
      builder: (context) {
        final S = AppLocal.of(context);
        final size = Flyout.of(context).size;
        return MenuFlyout(
          items: [
            MenuFlyoutSubItem(
              text: Text(S.tag_submenu_date_time),
              items: (_) =>
                  dateTimeHelp?.map((item) {
                    return MenuFlyoutItem(
                      text: TextHelpRow(
                        info: item,
                        tagWidth: 90,
                      ),
                      onPressed: () {
                        _setTag(item);
                        Flyout.of(context).close;
                      },
                    );
                  }).toList(growable: false) ??
                  [],
            ),
            MenuFlyoutSubItem(
              text: Text(S.tag_submenu_apk),
              items: (_) =>
                  apkHelp?.map((item) {
                    return MenuFlyoutItem(
                      text: TextHelpRow(
                        info: item,
                      ),
                      onPressed: () {
                        _setTag(item);
                        Flyout.of(context).close;
                      },
                    );
                  }).toList(growable: false) ??
                  [],
            ),
            const MenuFlyoutSeparator(),
            MenuFlyoutItem(
              text: Text(S.menu_save_template),
              onPressed: () {
                onSaveTemplate?.call();
                Flyout.of(context).close;
              },
            ),
            MenuFlyoutSubItem(
              text: Text(S.menu_my_templates),
              items: (context) {
                return myTemplates?.map((item) {
                      return MenuFlyoutItem(
                        text: SizedBox(
                          width: size.isEmpty ? null : size.width,
                          child: TemplateRow(
                            info: item,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(FluentIcons.delete, size: 18.0),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              onDeleteTemplate?.call(item);
                            });
                            Navigator.of(context).maybePop();
                          },
                        ),
                        onPressed: () {
                          _onSelectTemplate(item);
                          Flyout.of(context).close;
                        },
                      );
                    }).toList(growable: false) ??
                    [];
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final S = AppLocal.of(context);
    return FlyoutTarget(
      controller: _menuController,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: InputTextField(
              labelText: S.file_name_template,
              controller: controller,
            ),
          ),
          IconButton(
            icon: const Icon(
              FluentIcons.receipt_tentative,
              size: 24.0,
            ),
            onPressed: _showMenu,
          ),
        ],
      ),
    );
  }
}
