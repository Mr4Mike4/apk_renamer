part of 'settings_bloc.dart';

@Freezed(equal: false, makeCollectionsUnmodifiable: false)
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _InitialSettingsState;

  const factory SettingsState.load({
    required String aaptPath,
  }) = _LoadSettingsState;

  const factory SettingsState.selectAaptPath({
    required String aaptPath,
  }) = _SelectAaptPathSettingsState;

  const factory SettingsState.error({
    required String error,
  }) = _ErrorSettingsState;

  const factory SettingsState.success() = _SuccessSettingsState;
}
