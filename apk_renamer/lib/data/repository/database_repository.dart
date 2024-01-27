import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../database/config_dao.dart';
import '../database/template_dao.dart';

class DatabaseRepository {
  static const String dbName = 'ApkRenamer';

  Isar? _isar;

  Future<void> init(Directory directory) async {
    _isar = await Isar.open(
      [TemplateDaoSchema, ConfigDaoSchema],
      directory: directory.path,
      name: dbName,
      inspector: kDebugMode,
    );
  }

  Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not init');
    }
    return _isar!;
  }
}
