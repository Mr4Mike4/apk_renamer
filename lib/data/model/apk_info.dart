import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'apk_info.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class ApkInfo with _$ApkInfo {
  const factory ApkInfo({
    required String uuid,
    required File file,
    String? applicationId,
    String? versionCode,
    String? versionName,
    String? platformBuildVersionName,
    String? platformBuildVersionCode,
    String? compileSdkVersion,
    String? compileSdkVersionCodename,
    String? sdkVersion,
    String? targetSdkVersion,
    String? applicationLabel,
  }) = ApkInfoObj;
}
