import 'package:renamer_lib/model/template_info.dart';
import 'package:test/expect.dart';

class TemplateInfoMatcher extends Matcher {
  const TemplateInfoMatcher({
    this.all,
    this.tag,
    this.key,
  });

  final String? all;
  final String? tag;
  final String? key;

  @override
  bool matches(Object? item, Map matchState) {
    if (item.runtimeType != runtimeType &&
        item is! TemplateInfo) return false;
    final info = item as TemplateInfo;
    if (info.all != all) return false;
    if (info.tag != tag) return false;
    if (info.key != key) return false;
    return true;
  }

  @override
  Description describe(Description description) {
    return description
        .add('all: ')
        .addDescriptionOf(all)
        .add(', tag: ')
        .addDescriptionOf(tag)
        .add(', key: ')
        .addDescriptionOf(key);
  }
}
