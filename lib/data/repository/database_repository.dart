import 'dart:io';

import 'package:isar/isar.dart';

import '../database/pattern_dao.dart';

class DatabaseRepository {
  static const String dbName = 'ApkRenamer';

  Isar? _isar;

  Future<void> init(Directory directory) async {
    _isar = await Isar.open(
      [PatternDaoSchema],
      directory: directory.path,
      name: dbName,
      inspector: false,
    );
  }

  Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not init');
    }
    return _isar!;
  }
}
