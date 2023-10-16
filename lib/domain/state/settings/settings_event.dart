part of 'settings_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.load() = _LoadSettingsEvent;

  const factory SettingsEvent.selectAaptPath() = _SelectAaptPathSettingsEvent;

  const factory SettingsEvent.save({
    required String aaptPath,
  }) = _SaveSettingsEvent;
}
