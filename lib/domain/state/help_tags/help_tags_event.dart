part of 'help_tags_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class HelpTagsEvent with _$HelpTagsEvent {
  const factory HelpTagsEvent.started() = _StartedHelpTagsEvent;
}
