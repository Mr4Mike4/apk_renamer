import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/tag_info.dart';
import '../../../internal/application.dart';
import '../../../localizations.dart';
import 'input_text_field.dart';

class PatternWidget extends StatelessWidget {
  PatternWidget({
    super.key,
    this.controller,
    this.dateTimeHelp, this.apkHelp,
  });
  final TextEditingController? controller;

  final menuController = FlyoutController();

  final List<TagInfo>? dateTimeHelp;
  final List<TagInfo>? apkHelp;

  void _setTag(TagInfo info){
    final value = controller?.value;
    if(value != null){
      final sel = value.selection;
      final range = TextRange(
        start: sel.start,
        end: sel.end,
      );
      // logger.d('_setTag');
      controller?.value = value.replaced(range, info.tag);
    }
  }

  void _showMenu() {
    menuController.showFlyout(
      autoModeConfiguration: FlyoutAutoConfiguration(
        preferredMode: FlyoutPlacementMode.left,
      ),
      barrierDismissible: true,
      dismissOnPointerMoveAway: false,
      dismissWithEsc: true,
      navigatorKey: rootNavigatorKey.currentState,
      builder: (context) {
        final S = AppLocal.of(context);
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
                      onPressed: (){
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
                  onPressed: (){
                    _setTag(item);
                    Flyout.of(context).close;
                  },
                );
              }).toList(growable: false) ??
                  [],
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
      controller: menuController,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: InputTextField(
              labelText: S.file_name_mask,
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

class TextHelpRow extends StatelessWidget {
  const TextHelpRow({
    super.key,
    required this.info, this.tagWidth,
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
