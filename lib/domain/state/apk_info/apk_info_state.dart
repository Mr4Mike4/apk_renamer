part of 'apk_info_bloc.dart';

@Freezed(equal: false)
class ApkInfoState with _$ApkInfoState {
  const factory ApkInfoState.init() = ApkInfoInitial;

  const factory ApkInfoState.load({
    List<ApkInfo>? listInfo,
  }) = ApkInfoLoad;
}
