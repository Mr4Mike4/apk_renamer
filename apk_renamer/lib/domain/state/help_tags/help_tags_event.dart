part of 'help_tags_bloc.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class HelpTagsEvent with _$HelpTagsEvent {
  const factory HelpTagsEvent.started() = _StartedHelpTagsEvent;
  const factory HelpTagsEvent.saveTemplate({
    required String name,
    required String template,
  }) = _SaveTemplateHelpTagsEvent;
  const factory HelpTagsEvent.deleteTemplate({
    required int id,
  }) = _DeleteHelpTagsEvent;
}
