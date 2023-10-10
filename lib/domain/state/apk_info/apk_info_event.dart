part of 'apk_info_bloc.dart';

@freezed
class ApkInfoEvent with _$ApkInfoEvent {
  const factory ApkInfoEvent.init() = InitApkInfoEvent;
  const factory ApkInfoEvent.errorMsg(String? errorMsg) = MsgErrorApkInfoEvent;
  const factory ApkInfoEvent.openFiles() = OpenFilesApkInfoEvent;
  const factory ApkInfoEvent.updateFilesInfo({
    required String replacePattern,
  }) = UpdateFilesInfoEvent;
}
