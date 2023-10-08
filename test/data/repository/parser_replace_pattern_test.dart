import 'package:apk_renamer/data/repository/parser_replace_pattern.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  late ParserReplacePattern parserPattern;
  setUp(() {
    parserPattern = ParserReplacePattern();
  });
  test('parsePattern test', () async {

    final list = await parserPattern.parsePattern(r"csa-${apk.version}(${apk.version code})-${YMD}");

    for (final m in list) {
      print(m);
    }

    expect(list.length, 3);
  });
}