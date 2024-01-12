import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern_info.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class PatternInfo with _$PatternInfo {
  const factory PatternInfo({
    String? all,
    String? tag,
    String? key,
  }) = PatternInfoObj;
}