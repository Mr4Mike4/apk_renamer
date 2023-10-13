part of 'apk_info_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class ApkInfoEvent with _$ApkInfoEvent {
  const factory ApkInfoEvent.init() = InitApkInfoEvent;
  const factory ApkInfoEvent.openFiles() = OpenFilesApkInfoEvent;
  const factory ApkInfoEvent.updateFilesInfo({
    required String replacePattern,
  }) = UpdateFilesInfoEvent;
  const factory ApkInfoEvent.deleteFilesInfo({
    required String? uuid,
  }) = DeleteFilesInfoEvent;
  const factory ApkInfoEvent.renameFilesInfo() = RenameFilesInfoEvent;
  const factory ApkInfoEvent.changedEnable({
    required String? uuid,
    required bool checked,
  }) = ChangedEnableFilesInfoEvent;
}
