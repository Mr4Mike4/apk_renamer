import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:renamer_lib/model/file_info.dart';
import 'package:window_manager/window_manager.dart';

import '../../domain/model/tag_info.dart';
import '../../domain/state/apk_info/apk_info_bloc.dart';
import '../../domain/state/help_tags/help_tags_bloc.dart';
import '../../localizations.dart';
import 'custom/apk_table.dart';
import 'custom/checkbox_row.dart';
import 'custom/confirm_dialog.dart';
import 'custom/error_dialog.dart';
import 'custom/input_text_field.dart';
import 'custom/pattern_widget.dart';
import 'custom/vertical_split_view.dart';

class ApkListPage extends StatefulWidget {
  const ApkListPage({
    super.key,
  });

  @override
  State<ApkListPage> createState() => _ApkListPageState();
}

class _ApkListPageState extends State<ApkListPage> {
  late ApkInfoBloc _bloc;
  late HelpTagsBloc _blocHelpTags;

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
    _blocHelpTags = HelpTagsBloc()
    ..add(const HelpTagsEvent.started());
  }

  @override
  void dispose() {
    _replacePatternController.dispose();
    _destPathController.dispose();
    _copyToFolderController.dispose();
    super.dispose();
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

  void _showError(String error, {bool isFatal = false}) {
    showDialog<bool>(
      context: context,
      builder: (_) {
        return ErrorDialog(
          content: error,
        );
      },
    ).then((_) {
      if (isFatal) {
        windowManager.destroy();
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
      content: VerticalSplitView(
        ratio: 0.4,
        minWidthLeft: 300,
        minWidthRight: 300,
        left: Column(
          children: [
            BlocBuilder<HelpTagsBloc, HelpTagsState>(
              bloc: _blocHelpTags,
              builder: (context, state) {
                List<TagInfo>? dateTimeHelp;
                List<TagInfo>? apkHelp;
                state.mapOrNull(load: (st){
                  dateTimeHelp = st.dateTimeHelp;
                  apkHelp = st.apkHelp;
                });
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PatternWidget(
                    controller: _replacePatternController,
                    dateTimeHelp: dateTimeHelp,
                    apkHelp: apkHelp,
                  ),
                );
              },
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
            // Align(
            //   alignment: AlignmentDirectional.bottomStart,
            //   child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: IconButton(
            //         icon: const Icon(FluentIcons.settings, size: 24.0),
            //         onPressed: () => context.push('/settings'),
            //       )),
            // ),
          ],
        ),
        right: Padding(
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
                        _copyToFolderController.value =
                            st.copyToFolder ?? true;
                        return false;
                      },
                      fatalError: (st) {
                        _showError(st.error, isFatal: true);
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
                      loadApkInfo: (listInfo) =>
                          ApkTable(
                            key: const Key('apk_table'),
                            listInfo: listInfo,
                            onDeleteItem: _deleteItem,
                            onChangedEnable: _changedEnable,
                          ),
                      showProgress: () =>
                      const Center(child: ProgressRing()),
                      orElse: () =>
                      const ApkTable(
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
    );
  }
}
