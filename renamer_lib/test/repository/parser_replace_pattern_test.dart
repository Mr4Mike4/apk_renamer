import 'package:renamer_lib/repository/parser_replace_pattern.dart';
import 'package:test/test.dart';

import 'pattern_info_matcher.dart';

void main() {
  late ParserReplacePattern parserPattern;
  setUp(() {
    parserPattern = ParserReplacePattern();
  });
  test('parsePattern test', () async {
    final list = await parserPattern.parsePattern(
        r"csa-${apk.versionName}(${apk.versionCode})-${Y}${M}${D}");

    expect(list[0], const PatternInfoMatcher(
        all: r'${apk.versionName}',
        tag: 'apk',
        key: 'versionName',
    ));

    expect(list[1], const PatternInfoMatcher(
      all: r'${apk.versionCode}',
      tag: 'apk',
      key: 'versionCode',
    ));

    expect(list[2], const PatternInfoMatcher(
      all: r'${Y}',
      key: 'Y',
    ));

    expect(list[3], const PatternInfoMatcher(
      all: r'${M}',
      key: 'M',
    ));

    expect(list[4], const PatternInfoMatcher(
      all: r'${D}',
      key: 'D',
    ));
  });
}
