part of 'help_tags_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class HelpTagsEvent with _$HelpTagsEvent {
  const factory HelpTagsEvent.started() = _StartedHelpTagsEvent;
  const factory HelpTagsEvent.savePattern({
    required String name,
    required String pattern,
  }) = _SavePatternHelpTagsEvent;
  const factory HelpTagsEvent.deletePattern({
    required int id,
  }) = _DeleteHelpTagsEvent;
}
