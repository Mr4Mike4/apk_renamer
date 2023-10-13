import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/file_info.dart';
import '../../domain/state/apk_info/apk_info_bloc.dart';
import '../../localizations.dart';
import 'custom/apk_table.dart';
import 'custom/confirm_dialog.dart';
import 'custom/input_text_field.dart';

class ApkListPage extends StatefulWidget {
  const ApkListPage({
    super.key,
  });

  @override
  State<ApkListPage> createState() => _ApkListPageState();
}

class _ApkListPageState extends State<ApkListPage> {
  late ApkInfoBloc _bloc;

  final _replacePatternController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ApkInfoBloc();
  }

  void _deleteItem(FileInfo fileInfo) {
    final S = AppLocal.of(context);
    showDialog<bool>(
      context: context,
      builder: (_) {
        return ConfirmDialog(
          content: S.file_delete_confirm(fileInfo.currentFileName),
        );
      },
    ).then((result) {
      if (result == true) {
        _bloc.add(ApkInfoEvent.deleteFilesInfo(
          uuid: fileInfo.uuid,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);
    final S = AppLocal.of(context);
    return ScaffoldPage(
      // header: const PageHeader(
      //   title: Text('Fluent UI for Flutter Showcase App'),
      // ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: 400,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputTextField(
                      labelText: S.file_name_mask,
                      controller: _replacePatternController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        _bloc.add(const ApkInfoEvent.openFiles());
                      },
                      child: Text(S.btn_add_files),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        _bloc.add(ApkInfoEvent.updateFilesInfo(
                          replacePattern: _replacePatternController.text,
                        ));
                      },
                      child: Text(S.btn_preview),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ApkInfoBloc, ApkInfoState>(
                bloc: _bloc,
                builder: (context, state) {
                  return state.maybeWhen(
                    load: (listInfo) => ApkTable(
                      key: const Key('apk_table'),
                      listInfo: listInfo,
                      onDeleteItem: _deleteItem,
                    ),
                    showProgress: () => const Center(child: ProgressRing()),
                    orElse: () => const ApkTable(
                      key: Key('apk_table'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
