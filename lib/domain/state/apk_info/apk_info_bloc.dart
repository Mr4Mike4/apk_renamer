import 'dart:async';
import 'dart:io';

import 'package:apk_renamer/data/repository/parser_apk_info.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

import '../../../data/repository/parser_replace_pattern.dart';
import '../../../data/repository/renamer_files.dart';
import '../../../logger.dart';
import '../../model/file_info.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {
  ApkInfoBloc() : super(const ApkInfoState.init()) {
    on<OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
    on<UpdateFilesInfoEvent>(_onUpdateFilesInfoEvent);
  }

  final ParserApkInfo _parserApkInfo = ParserApkInfo();
  final ParserReplacePattern _parserPattern = ParserReplacePattern();

  List<FileInfo>? _listInfo;

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
    _parserApkInfo.aaptInit();
    final list = _listInfo??[];
    if (list.isNotEmpty) {
      final patternInfo = await _parserPattern.parsePattern(pattern);
      final renamer = RenamerFiles(
          pattern: pattern,
          patternInfo: patternInfo,
      );
      for(int i = 0; i <list.length; i++) {
        final info = list[i];
        final apkInfo = await _parserApkInfo.parseFile(info.file);
        final newFileName = await renamer.createNewName(apkInfo);
        list[i] = info.copyWith(
          newFileName: newFileName,
        );
      }
    }
    emit.call(ApkInfoState.load(
      listInfo: _listInfo,
    ));
  }
}
