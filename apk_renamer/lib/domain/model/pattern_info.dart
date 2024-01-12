import 'package:apk_renamer/data/database/pattern_dao.dart';

class PatternInfo {
  PatternInfo({
    required this.id,
    required this.name,
    required this.patternStr,
  });

  int id;
  String name;
  String patternStr;
}

extension PatternDaoExt on PatternDao {
  PatternInfo toModel() => PatternInfo(
      id: id,
      name: name,
      patternStr: patternStr,
    );
}
