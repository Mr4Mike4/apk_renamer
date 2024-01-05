import 'package:fluent_ui/fluent_ui.dart';

import '../../../domain/model/pattern_info.dart';
import '../../../domain/model/tag_info.dart';
import '../../../internal/application.dart';
import '../../../localizations.dart';
import 'input_text_field.dart';
import 'pattern_row.dart';
import 'text_help_row.dart';

typedef PatternInfoCallback = void Function(PatternInfo duration);

class PatternWidget extends StatelessWidget {
  PatternWidget({
    super.key,
    this.controller,
    this.onSavePattern,
    this.dateTimeHelp,
    this.apkHelp,
    this.myPatterns,
  });

  final TextEditingController? controller;
  final VoidCallback? onSavePattern;
  final List<TagInfo>? dateTimeHelp;
  final List<TagInfo>? apkHelp;
  final List<PatternInfo>? myPatterns;

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

  void _onSelectPattern(PatternInfo info) {
    controller?.text = info.patternStr;
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
              text: Text(S.menu_save_pattern),
              onPressed: () {
                onSavePattern?.call();
                Flyout.of(context).close;
              },
            ),
            MenuFlyoutSubItem(
              text: Text(S.menu_my_patterns),
              items: (_) =>
                  myPatterns?.map((item) {
                    return MenuFlyoutItem(
                      text: PatternRow(
                        info: item,
                      ),
                      onPressed: () {
                        _onSelectPattern(item);
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
      controller: _menuController,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: InputTextField(
              labelText: S.file_name_pattern,
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
