import 'dart:isolate';

import '../../domain/model/file_info.dart';

sealed class IsolateMsgObj {
  IsolateMsgObj({required this.sendReturnPort});

  final SendPort sendReturnPort;
}

class UpdateFilesInfo extends IsolateMsgObj {

  UpdateFilesInfo({
    required super.sendReturnPort,
    required this.pattern,
    required this.listInfo,
  });
  final String pattern;
  final List<FileInfo> listInfo;
}

