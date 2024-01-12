import '../model/pattern_info.dart';

class ParserReplacePattern {
  final _regExpPattern = RegExp(r"\$\{(?:([^\{]*)\.)?([^\{]+)\}");

  Future<List<PatternInfo>> parsePattern(String pattern) async {
    final list = <PatternInfo>[];
    final matches = _regExpPattern.allMatches(pattern);
    for (final m in matches) {
      list.add(PatternInfo(
        all: m[0],
        tag: m[1],
        key: m[2],
      ));
    }
    return List.unmodifiable(list);
  }
}