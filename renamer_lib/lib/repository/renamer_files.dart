import 'package:date_format/date_format.dart' as df;
import 'package:parser_apk_info/model/apk_info.dart';
import 'package:parser_apk_info/repository/apk_util.dart';
import 'package:path/path.dart' as p;

import '../model/keys.dart';
import '../model/pattern_info.dart';

class RenamerFiles {

  RenamerFiles({
    required this.pattern,
    required this.patternInfo,
  });

  final List<PatternInfo> patternInfo;
  final String pattern;
  final DateTime _now = DateTime.now();

  String _fromDateFormat(final String newPattern) {
    return df.formatDate(_now, [newPattern]);
  }

  String _fromInfo(final String? apkKey, final ApkInfo? apkInfo) {
    String? data;
    switch(apkKey){
      case Keys.origName:
        final path = apkInfo?.file.path;
        if(path != null) {
          data = p.basename(path);
        }
        break;
      // dateTime
      case Keys.dateTimeFullYear: data = _fromDateFormat(df.yyyy);
      case Keys.dateTimeYearLastTwoDigits: data = _fromDateFormat(df.yy);
      // case Keys.dateTimeYearLastDigit: data = _fromDateFormat('');
      case Keys.dateTimeMonthName: data = _fromDateFormat(df.MM);
      // case Keys.dateTimeMonthNameAbbr: data = _fromDateFormat('');
      case Keys.dateTimeMonthDigitZero: data = _fromDateFormat(df.mm);
      case Keys.dateTimeMonthDigit: data = _fromDateFormat(df.m);
      // case Keys.dateTimeDayName: data = _fromDateFormat('');
      // case Keys.dateTimeDayNameAbbr: data = _fromDateFormat('');
      case Keys.dateTimeDayDigitZero: data = _fromDateFormat(df.dd);
      case Keys.dateTimeDayDigit: data = _fromDateFormat(df.d);
      case Keys.dateTimeHoursZero: data = _fromDateFormat(df.HH);
      // case Keys.dateTimeHours: data = _fromDateFormat('');
      case Keys.dateTimeMinutesZero: data = _fromDateFormat(df.nn);
      case Keys.dateTimeMinutes: data = _fromDateFormat(df.n);
      case Keys.dateTimeSecondsZero: data = _fromDateFormat(df.ss);
      case Keys.dateTimeSeconds: data = _fromDateFormat(df.s);
      case Keys.dateTimeMilliSeconds3D: data = _fromDateFormat(df.SSS);
      // case Keys.dateTimeMilliSeconds2D: data = _fromDateFormat(df.S);
      case Keys.dateTimeMilliSeconds1D: data = _fromDateFormat(df.S);
    }
    return data ?? '';
  }

  Future<String?> createNewName(final ApkInfo? apkInfo) async {
    if (apkInfo == null) {
      return null;
    }
    String newName = pattern;
    for (final info in patternInfo) {
      final from = info.all;
      if (from != null) {
        String replace = '';
        switch(info.tag){
          case Tags.apk:
            replace = ApkUtil.fromApkInfo(info.key, apkInfo);
            break;
            default:
              replace = _fromInfo(info.key, apkInfo);
              break;
        }
        newName = newName.replaceAll(from, replace);
      }
    }
    return newName;
  }
}