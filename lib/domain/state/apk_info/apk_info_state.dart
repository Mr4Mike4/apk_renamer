part of 'apk_info_bloc.dart';

@Freezed(
    equal: false,
    makeCollectionsUnmodifiable: false
)
class ApkInfoState with _$ApkInfoState {
  const factory ApkInfoState.init() = ApkInfoInitial;
  // const factory ApkInfoState.errorMsg(String? errorMsg) = AuthStateMsgError;
  const factory ApkInfoState.load({
    List<FileInfo>? listInfo,
  }) = ApkInfoLoad;

  const factory ApkInfoState.showProgress() = AuthStateShowProgress;
  const factory ApkInfoState.hideProgress() = AuthStateHideProgress;

}
