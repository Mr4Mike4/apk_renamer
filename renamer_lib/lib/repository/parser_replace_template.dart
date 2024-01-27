import '../model/template_info.dart';

class ParserReplaceTemplate {
  final _regExpTemplate = RegExp(r"\$\{(?:([^\{]*)\.)?([^\{]+)\}");

  Future<List<TemplateInfo>> parseTemplate(String template) async {
    final list = <TemplateInfo>[];
    final matches = _regExpTemplate.allMatches(template);
    for (final m in matches) {
      list.add(TemplateInfo(
        all: m[0],
        tag: m[1],
        key: m[2],
      ));
    }
    return List.unmodifiable(list);
  }
}