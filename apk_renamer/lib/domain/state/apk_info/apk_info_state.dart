part of 'apk_info_bloc.dart';

@Freezed(
  equal: false,
  makeCollectionsUnmodifiable: false,
)
class ApkInfoState with _$ApkInfoState {
  const factory ApkInfoState.init() = _InitialApkInfoState;

  const factory ApkInfoState.load({
    required String? destPath,
    required bool? copyToFolder,
    required String? template,
  }) = _LoadApkInfoState;

  const factory ApkInfoState.loadApkInfo({
    List<FileInfo>? listInfo,
  }) = _LoadApkInfoApkInfoState;

  const factory ApkInfoState.error({
    required String error,
  }) = _ErrorApkInfoState;

  const factory ApkInfoState.fatalError({
    required String error,
  }) = _FatalErrorApkInfoState;

  const factory ApkInfoState.showProgress() = _ShowProgressApkInfoState;

  const factory ApkInfoState.hideProgress() = _HideProgressApkInfoState;

  const factory ApkInfoState.selectDestPath({
    required String? destPath,
  }) = _SelectDestPathApkInfoState;
}
