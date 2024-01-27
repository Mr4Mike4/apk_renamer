import 'package:renamer_lib/repository/parser_replace_template.dart';
import 'package:test/test.dart';

import 'template_info_matcher.dart';

void main() {
  late ParserReplaceTemplate parserTemplate;
  setUp(() {
    parserTemplate = ParserReplaceTemplate();
  });
  test('parseTemplate test', () async {
    final list = await parserTemplate.parseTemplate(
        r"csa-${apk.versionName}(${apk.versionCode})-${Y}${M}${D}");

    expect(list[0], const TemplateInfoMatcher(
        all: r'${apk.versionName}',
        tag: 'apk',
        key: 'versionName',
    ));

    expect(list[1], const TemplateInfoMatcher(
      all: r'${apk.versionCode}',
      tag: 'apk',
      key: 'versionCode',
    ));

    expect(list[2], const TemplateInfoMatcher(
      all: r'${Y}',
      key: 'Y',
    ));

    expect(list[3], const TemplateInfoMatcher(
      all: r'${M}',
      key: 'M',
    ));

    expect(list[4], const TemplateInfoMatcher(
      all: r'${D}',
      key: 'D',
    ));
  });
}
