import 'package:apk_renamer/presentation/views/custom/error_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/state/settings/settings_bloc.dart';
import '../../localizations.dart';
import 'custom/input_text_field.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsBloc _bloc;

  final _aaptPathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = SettingsBloc()
    ..add(const SettingsEvent.load());
  }

  void _showError(String error) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialog(
          content: error,
        ),
    ).then((result) {
    });
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
                _aaptPathController.text = st.aaptPath;
              },
              selectAaptPath: (st) {
                _aaptPathController.text = st.aaptPath;
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
                    width: 600,
                    child: InputTextField(
                      labelText: S.settings_aapt_path,
                      controller: _aaptPathController,
                      readOnly: true,
                    ),
                  ),
                  Button(
                    child: Text(S.btn_select),
                    onPressed: () {
                      _bloc.add(const SettingsEvent.selectAaptPath());
                    },
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
                        aaptPath: _aaptPathController.text,
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
