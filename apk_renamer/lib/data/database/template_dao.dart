import 'package:isar/isar.dart';

part 'template_dao.g.dart';

@collection
@Name("Template")
class TemplateDao {
  TemplateDao({
    this.id = Isar.autoIncrement,
    required this.templateStr,
    required this.name,
  });

  Id id;
  @Index(type: IndexType.value)
  String name;
  String templateStr;
}