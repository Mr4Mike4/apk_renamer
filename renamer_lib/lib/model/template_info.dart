import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_info.freezed.dart';

@Freezed(
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class TemplateInfo with _$TemplateInfo {
  const factory TemplateInfo({
    String? all,
    String? tag,
    String? key,
  }) = TemplateInfoObj;
}