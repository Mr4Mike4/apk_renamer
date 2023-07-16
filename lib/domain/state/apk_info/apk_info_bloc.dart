import 'dart:async';
import 'dart:io';

import 'package:apk_renamer/data/repository/apk_info.dart';
import 'package:apk_renamer/data/repository/parser_apk_info.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../logger.dart';

part 'apk_info_bloc.freezed.dart';
part 'apk_info_event.dart';
part 'apk_info_state.dart';

class ApkInfoBloc extends Bloc<ApkInfoEvent, ApkInfoState> {
  ApkInfoBloc() : super(const ApkInfoState.init()) {
    on<OpenFilesApkInfoEvent>(_onOpenFilesApkInfoEvent);
  }

  final ParserApkInfo _parserApkInfo = ParserApkInfo();

  FutureOr<void> _onOpenFilesApkInfoEvent(
      OpenFilesApkInfoEvent event, Emitter<ApkInfoState> emit) async {
    logger.d('OpenFilesApkInfoEvent');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
      allowMultiple: true,
      lockParentWindow: true,
    );
    List<ApkInfo>? listInfo;
    if (result != null) {
      logger.d('OpenFilesApkInfoEvent >> ${result.paths}');
      final paths = result.paths;
      if (paths.isNotEmpty) {
        _parserApkInfo.aaptInit();
        final files = paths.where((e) => e != null).map((e) => File(e!));
        listInfo = await _parserApkInfo.parseFiles(files);
      }
    } else {
      logger.d('OpenFilesApkInfoEvent >> no select');
    }
    emit.call(ApkInfoState.load(
      listInfo: listInfo,
    ));
  }
}
