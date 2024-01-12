import 'dart:io';

import 'package:renamer_lib/model/file_info.dart';
import 'package:test/expect.dart';

class FileInfoMatcher extends Matcher {
  const FileInfoMatcher({
    // required this.uuid,
    required this.file,
    required this.currentFileName,
    this.newFileName,
    this.isEnable = true,
  });

  // final String uuid;
  final File file;
  final String currentFileName;
  final String? newFileName;
  final bool isEnable;

  @override
  bool matches(Object? item, Map matchState) {
    if(item.runtimeType != runtimeType &&
        item is! FileInfo) return false;
    final info = item as FileInfo;
    // if(info.uuid != uuid) return false;
    if(info.file.path != file.path) return false;
    if(info.currentFileName != currentFileName) return false;
    if(info.newFileName != newFileName) return false;
    if(info.isEnable != isEnable) return false;
    return true;
  }
  @override
  Description describe(Description description) {
    return description
        .add('file: ')
        .addDescriptionOf(file.path)
        .add(', currentFileName: ')
        .addDescriptionOf(currentFileName)
        .add(', newFileName: ')
        .addDescriptionOf(newFileName)
        .add(', isEnable: ')
        .addDescriptionOf(isEnable);
  }
}