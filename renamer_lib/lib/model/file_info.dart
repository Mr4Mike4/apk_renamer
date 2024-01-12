import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_info.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class FileInfo with _$FileInfo {
  const factory FileInfo({
    required String uuid,
    required File file,
    required String currentFileName,
    String? newFileName,
    @Default(true) bool isEnable,
  }) = _FileInfoObj;
}