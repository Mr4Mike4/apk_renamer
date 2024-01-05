part of 'help_tags_bloc.dart';

@Freezed(
  equal: false,
  makeCollectionsUnmodifiable: false,
)
class HelpTagsState with _$HelpTagsState {
  const factory HelpTagsState.initial() = _InitialHelpTagsState;
  const factory HelpTagsState.load({
    required List<TagInfo>? dateTimeHelp,
    required List<TagInfo>? apkHelp,
    required List<PatternInfo>? myPatterns,
  }) = _LoadHelpTagsState;
  const factory HelpTagsState.updatePatterns({
    required List<PatternInfo>? myPatterns,
  }) = _UpdatePatternsHelpTagsState;
}
