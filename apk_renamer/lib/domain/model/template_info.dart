import 'package:apk_renamer/data/database/template_dao.dart';

class TemplateInfo {
  TemplateInfo({
    required this.id,
    required this.name,
    required this.templateStr,
  });

  int id;
  String name;
  String templateStr;
}

extension TemplateDaoExt on TemplateDao {
  TemplateInfo toModel() => TemplateInfo(
      id: id,
      name: name,
      templateStr: templateStr,
    );
}
