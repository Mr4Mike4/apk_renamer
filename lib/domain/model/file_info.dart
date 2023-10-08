import 'dart:ffi';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_info.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class FileInfo with _$FileInfo {
  const factory FileInfo({
    required File file,
    required String currentFileName,
    String? newFileName,
    Bool? isEnable,
  }) = _FileInfoObj;
}