import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../../data/model/file_info.dart';
import '../../../data/model/settings_obj.dart';
import '../../../data/rename_isolate/rename_isolate.dart';
import '../../../data/repository/preferences_repository.dart';
import '../../../internal/localiz.dart';
import '../../../logger.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {
  ApkInfoBloc(this._renameIsolate, this._pref)
      : super(const ApkInfoState.init()) {
    on<_InitApkInfoEvent>(_onInitApkInfoEvent);
    on<_OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
    on<_UpdateFilesInfoEvent>(_onUpdateFilesInfoEvent);
    on<_DeleteFilesInfoEvent>(_onDeleteFilesInfoEvent);
    on<_RenameFilesInfoEvent>(_onRenameFilesInfoEvent);
    on<_ChangedEnableFilesInfoEvent>(_onChangedEnableFilesInfoEvent);
    on<_SelectDestPathSettingsEvent>(_onSelectDestPathSettingsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
    add(const ApkInfoEvent.init());
  }

  final List<FileInfo> _listInfo = [];

  final RenameIsolate _renameIsolate;
  final PreferencesRepository _pref;
  late final AppLocalizations _S;

  FutureOr<void> _onInitApkInfoEvent(
      _InitApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    final aaptPath = await _pref.getAaptPath();
    if (aaptPath != null) {
      await _renameIsolate.init(SettingsObj(
        aaptPath: aaptPath,
      ));
    }
    final destPath = await _pref.getDestPath();
    final copyToFolder = await _pref.getCopyToFolder();
    emit.call(ApkInfoState.load(
      destPath: destPath,
      copyToFolder: copyToFolder,
    ));
  }

  FutureOr<void> _onOpenFilesApkInfoEvent(
      _OpenFilesApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('_OpenFilesApkInfoEvent');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
      allowMultiple: true,
      lockParentWindow: true,
    );
    emit.call(const ApkInfoState.showProgress());
    if (result != null) {
      logger.d('_OpenFilesApkInfoEvent >> ${result.paths}');
      final paths = result.paths.whereNotNull().toList();
      if (paths.isNotEmpty) {
        final listApkInfo = await _renameIsolate.getApkInfo(paths);
        final listInfo = listApkInfo?.map((e) => FileInfo(
              uuid: e.uuid,
              file: e.file,
              currentFileName: p.basename(e.file.path),
            ));
        if (listInfo != null) {
          _listInfo.addAll(listInfo);
        }
      }
    } else {
      logger.d('_OpenFilesApkInfoEvent >> no select');
    }
    emit.call(ApkInfoState.loadApkInfo(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onUpdateFilesInfoEvent(
      _UpdateFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    final pattern = event.replacePattern;
    logger.d('_UpdateFilesInfoEvent pattern >> $pattern');
    emit.call(const ApkInfoState.showProgress());
    final list = _listInfo;
    if (list.isNotEmpty) {
      final listInfo = await _renameIsolate.createNewName(pattern, list);
      if (listInfo != null) {
        _listInfo.clear();
        _listInfo.addAll(listInfo);
      }
    }
    emit.call(ApkInfoState.loadApkInfo(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onDeleteFilesInfoEvent(
      _DeleteFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    final uuid = event.uuid;
    logger.d('_DeleteFilesInfoEvent uuid >> $uuid');
    if (uuid == null) return;
    final info = _listInfo.firstWhereOrNull((e) => e.uuid == uuid);
    if (info != null) {
      await _renameIsolate.deleteFileInfo(uuid);
      _listInfo.remove(info);
      emit.call(ApkInfoState.loadApkInfo(
        listInfo: _listInfo,
      ));
    }
  }

  FutureOr<void> _onRenameFilesInfoEvent(
      _RenameFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('_RenameFilesInfoEvent');
    final copyToFolder = event.copyToFolder??false;
    await _pref.setCopyToFolder(copyToFolder);
    final list = _listInfo;
    if (list.isNotEmpty) {
      String? destPath;
      if (copyToFolder && event.destPath?.isNotEmpty == true) {
        destPath = event.destPath;
      }
      final listInfo = await _renameIsolate.renameFilesInfo(list,
          destPath: destPath,
      );
      if (listInfo != null) {
        _listInfo.clear();
        _listInfo.addAll(listInfo);
      }
    }
    emit.call(ApkInfoState.loadApkInfo(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onChangedEnableFilesInfoEvent(
      _ChangedEnableFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    final uuid = event.uuid;
    logger.d('_ChangedEnableFilesInfoEvent uuid >> $uuid');
    for (int i = 0; i < _listInfo.length; i++) {
      final info = _listInfo[i];
      if (info.uuid == uuid) {
        _listInfo[i] = info.copyWith(
          isEnable: event.checked,
        );
        break;
      }
    }
    emit.call(ApkInfoState.loadApkInfo(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onSelectDestPathSettingsEvent(
      _SelectDestPathSettingsEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('_SelectDestPathSettingsEvent');
    final destPath = await FilePicker.platform.getDirectoryPath(
      dialogTitle: _S.select_dest_folder,
      lockParentWindow: true,
    );
    if (destPath != null) {
      logger.d('_SelectDestPathSettingsEvent >> $destPath');
      await _pref.setDestPath(destPath);
      emit.call(ApkInfoState.selectDestPath(
        destPath: destPath,
      ));
    }
  }
}
