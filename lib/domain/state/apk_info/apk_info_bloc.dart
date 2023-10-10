import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../../data/rename_isolate/rename_isolate.dart';
import '../../../logger.dart';
import '../../model/file_info.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {

  ApkInfoBloc() : super(const ApkInfoState.init()) {
    on<InitApkInfoEvent>(_onInitApkInfoEvent);
    on<OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
    on<UpdateFilesInfoEvent>(_onUpdateFilesInfoEvent);
    add(const ApkInfoEvent.init());
  }

  List<FileInfo>? _listInfo;
  
  final _renameIsolate = RenameIsolate();

  FutureOr<void> _onInitApkInfoEvent(InitApkInfoEvent event, Emitter<ApkInfoState> emit) async {
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
    if (result != null) {
      logger.d('OpenFilesApkInfoEvent >> ${result.paths}');
      final paths = result.paths;
      if (paths.isNotEmpty) {
        // _parserApkInfo.aaptInit();
        _listInfo = paths.whereNotNull().map((e) => FileInfo(
            file: File(e),
            currentFileName: p.basename(e),
          )).toList();
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
    final list = _listInfo??[];
    if (list.isNotEmpty) {
      _listInfo = await _renameIsolate.createNewName(pattern, list);
    }
    emit.call(ApkInfoState.load(
      listInfo: _listInfo,
    ));
  }
}
