import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../../data/model/file_info.dart';
import '../../../data/rename_isolate/rename_isolate.dart';
import '../../../logger.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {
  ApkInfoBloc() : super(const ApkInfoState.init()) {
    on<InitApkInfoEvent>(_onInitApkInfoEvent);
    on<OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
    on<UpdateFilesInfoEvent>(_onUpdateFilesInfoEvent);
    on<DeleteFilesInfoEvent>(_onDeleteFilesInfoEvent);
    add(const ApkInfoEvent.init());
  }

  List<FileInfo> _listInfo = [];

  final _renameIsolate = RenameIsolate();

  FutureOr<void> _onInitApkInfoEvent(
      InitApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    await _renameIsolate.init();
  }

  FutureOr<void> _onOpenFilesApkInfoEvent(
      OpenFilesApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('OpenFilesApkInfoEvent');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
      allowMultiple: true,
      lockParentWindow: true,
    );
    emit.call(const ApkInfoState.showProgress());
    if (result != null) {
      logger.d('OpenFilesApkInfoEvent >> ${result.paths}');
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
      logger.d('OpenFilesApkInfoEvent >> no select');
    }
    emit.call(ApkInfoState.load(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onUpdateFilesInfoEvent(
      UpdateFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    final pattern = event.replacePattern;
    logger.d('UpdateFilesInfoEvent pattern >> $pattern');
    emit.call(const ApkInfoState.showProgress());
    final list = _listInfo;
    if (list.isNotEmpty) {
      final listInfo = await _renameIsolate.createNewName(pattern, list);
      if (listInfo != null) {
        _listInfo.clear();
        _listInfo.addAll(listInfo);
      }
    }
    emit.call(ApkInfoState.load(
      listInfo: _listInfo,
    ));
  }

  FutureOr<void> _onDeleteFilesInfoEvent(
      DeleteFilesInfoEvent event, Emitter<ApkInfoState> emit) async {
    final uuid = event.uuid;
    logger.d('DeleteFilesInfoEvent uuid >> $uuid');
    if (uuid == null) return;
    final info = _listInfo.firstWhereOrNull((e) => e.uuid == uuid);
    if (info != null) {
      await _renameIsolate.deleteFileInfo(uuid);
      _listInfo.remove(info);
      emit.call(ApkInfoState.load(
        listInfo: _listInfo,
      ));
    }
  }
}
