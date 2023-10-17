import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kiwi/kiwi.dart';

import '../../data/model/file_info.dart';
import '../../domain/state/apk_info/apk_info_bloc.dart';
import '../../localizations.dart';
import 'custom/apk_table.dart';
import 'custom/checkbox_row.dart';
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
  final _destPathController = TextEditingController();
  final _copyToFolderController = ValueNotifier<bool?>(true);

  @override
  void initState() {
    super.initState();
    final di = KiwiContainer();
    _bloc = ApkInfoBloc(
      di.resolve(),
      di.resolve(),
    );
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

  void _changedEnable(bool? checked, FileInfo fileInfo) {
    _bloc.add(ApkInfoEvent.changedEnable(
      uuid: fileInfo.uuid,
      checked: checked ?? false,
    ));
  }

  void _renameFiles() {
    _bloc.add(ApkInfoEvent.renameFilesInfo(
      destPath: _destPathController.text,
      copyToFolder: _copyToFolderController.value,
    ));
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
          Expanded(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CheckBoxRow(
                      text: S.copy_to_folder,
                      checkboxController: _copyToFolderController,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: _renameFiles,
                      child: Text(S.btn_rename_files),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(FluentIcons.settings, size: 24.0),
                          onPressed: () => context.push('/settings'),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ApkInfoBloc, ApkInfoState>(
                      bloc: _bloc,
                      buildWhen: (previous, current) {
                        return current.maybeMap(
                          load: (st) {
                            _destPathController.text = st.destPath ?? '';
                            _replacePatternController.text = st.pattern ?? '';
                            _copyToFolderController.value = st.copyToFolder??true;
                            return false;
                          },
                          selectDestPath: (st) {
                            _destPathController.text = st.destPath ?? '';
                            return false;
                          },
                          orElse: () => true,
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loadApkInfo: (listInfo) => ApkTable(
                            key: const Key('apk_table'),
                            listInfo: listInfo,
                            onDeleteItem: _deleteItem,
                            onChangedEnable: _changedEnable,
                          ),
                          showProgress: () =>
                              const Center(child: ProgressRing()),
                          orElse: () => const ApkTable(
                            key: Key('apk_table'),
                          ),
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder<bool?>(
                      valueListenable: _copyToFolderController,
                      builder: (BuildContext context, value, child) {
                        final visible = value ?? false;
                        return Visibility(
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: visible,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: InputTextField(
                                  labelText: S.dest_folder,
                                  controller: _destPathController,
                                  readOnly: true,
                                ),
                              ),
                              Button(
                                child: Text(S.btn_select),
                                onPressed: () {
                                  _bloc
                                      .add(const ApkInfoEvent.selectDestPath());
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
