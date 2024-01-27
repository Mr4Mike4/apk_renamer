part of 'apk_info_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class ApkInfoEvent with _$ApkInfoEvent {
  const factory ApkInfoEvent.init() = _InitApkInfoEvent;

  const factory ApkInfoEvent.openFiles() = _OpenFilesApkInfoEvent;

  const factory ApkInfoEvent.updateFilesInfo({
    required String replaceTemplate,
  }) = _UpdateFilesInfoEvent;

  const factory ApkInfoEvent.deleteFilesInfo({
    required String? uuid,
  }) = _DeleteFilesInfoEvent;

  const factory ApkInfoEvent.renameFilesInfo({
    String? destPath,
    bool? copyToFolder,
  }) = _RenameFilesInfoEvent;

  const factory ApkInfoEvent.changedEnable({
    required String? uuid,
    required bool checked,
  }) = _ChangedEnableFilesInfoEvent;

  const factory ApkInfoEvent.selectDestPath() = _SelectDestPathSettingsEvent;
}
