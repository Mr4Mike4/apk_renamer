import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parser_apk_info/repository/aapt_util.dart';
import 'package:path/path.dart' as path;
import 'package:renamer_lib/model/aapt_path_util.dart';
import 'package:renamer_lib/model/file_info.dart';

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
    final aaptDirPath = AaptPathUtil.getAaptApp(kDebugMode);
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath == null) {
      emit.call(ApkInfoState.fatalError(
        error: _S.error_aapt_not_found,
      ));
      return;
    }
    final destPath = await _pref.getDestPath();
    final copyToFolder = await _pref.getCopyToFolder();
    final template = await _pref.getTemplate();
    emit.call(ApkInfoState.load(
      destPath: destPath,
      copyToFolder: copyToFolder,
      template: template,
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
              currentFileName: path.basename(e.file.path),
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
    final template = event.replaceTemplate;
    logger.d('_UpdateFilesInfoEvent template >> $template');
    emit.call(const ApkInfoState.showProgress());
    await _pref.setTemplate(template);
    final list = _listInfo;
    if (list.isNotEmpty) {
      final listInfo = await _renameIsolate.createNewName(template, list);
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
