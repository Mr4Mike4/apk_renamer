import 'package:apk_renamer/presentation/views/custom/error_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';
import 'package:renamer_lib/model/keys.dart';

import '../../domain/state/settings/settings_bloc.dart';
import '../../localizations.dart';
import 'custom/info_label2.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc _bloc;

  static const _countSuffix = Keys2.countSuffix;

  final _countSuffixController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final di = KiwiContainer();
    _bloc = SettingsBloc(
      di.resolve(),
      di.resolve(),
    )..add(const SettingsEvent.load());
  }

  void _showError(String error) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(
        content: error,
      ),
    ).then((result) {});
  }

  void _addCountSuffix() {
    final value = _countSuffixController.value;
    final text = value.text;
    if (!text.contains(_countSuffix)) {
      final sel = value.selection;
      final range = TextRange(
        start: sel.start,
        end: sel.end,
      );
      _countSuffixController.value = value.replaced(range, _countSuffix);
    } else {
      final S = AppLocal.of(context);
      _showError(S.settings_count_suffix_one);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);
    final S = AppLocal.of(context);
    return ScaffoldPage(
      header: PageHeader(
        title: Text(S.settings_title),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<SettingsBloc, SettingsState>(
          bloc: _bloc,
          listener: (context, state) {
            state.mapOrNull(
              success: (_) {
                context.pop();
              },
              load: (st) {
                _countSuffixController.text = st.countSuffix;
              },
              error: (st) {
                _showError(st.error);
              },
            );
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    child: InfoLabel2(
                      label: S.settings_count_suffix,
                      tooltip: S.settings_count_suffix_descr,
                      child: TextBox(
                        controller: _countSuffixController,
                      ),
                    )
                  ),
                  IconButton(
                    icon: const Icon(FluentIcons.add_to, size: 18.0),
                    onPressed: _addCountSuffix,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    child: Text(S.btn_save),
                    onPressed: () {
                      _bloc.add(SettingsEvent.save(
                        countSuffix: _countSuffixController.text,
                      ));
                    },
                  ),
                  Button(
                    child: Text(S.btn_cancel),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
