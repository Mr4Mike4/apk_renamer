import 'package:apk_renamer/logger.dart';
import 'package:parser_apk_info/repository/logger.dart';

class AppLogger implements Logger {
  @override
  void d(Object? message) {
    logger.d(message);
  }

  @override
  void e(Object? message) {
    logger.e(message);
  }

  @override
  void f(Object? message) {
    logger.f(message);
  }

  @override
  void i(Object? message) {
    logger.i(message);
  }

  @override
  void t(Object? message) {
    logger.t(message);
  }

  @override
  void w(Object? message) {
    logger.w(message);
  }

}
