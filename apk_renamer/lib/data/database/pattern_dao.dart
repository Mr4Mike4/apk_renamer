import 'package:isar/isar.dart';

part 'pattern_dao.g.dart';

@collection
@Name("Pattern")
class PatternDao {
  PatternDao({
    this.id = Isar.autoIncrement,
    required this.patternStr,
    required this.name,
  });

  Id id;
  @Index(type: IndexType.value)
  String name;
  String patternStr;
}