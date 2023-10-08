import 'package:apk_renamer/data/model/keys.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../model/apk_info.dart';
import '../model/apk_util.dart';
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
    return DateFormat(newPattern).format(_now);
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
      case Keys.dateTimeFullYear: data = _fromDateFormat('yyyy');
      case Keys.dateTimeYearLastTwoDigits: data = _fromDateFormat('yy');
      // case Keys.dateTimeYearLastDigit: data = _fromDateFormat('');
      case Keys.dateTimeMonthName: data = _fromDateFormat('MMMM');
      // case Keys.dateTimeMonthNameAbbr: data = _fromDateFormat('');
      case Keys.dateTimeMonthDigitZero: data = _fromDateFormat('MM');
      case Keys.dateTimeMonthDigit: data = _fromDateFormat('M');
      // case Keys.dateTimeDayName: data = _fromDateFormat('');
      // case Keys.dateTimeDayNameAbbr: data = _fromDateFormat('');
      case Keys.dateTimeDayDigitZero: data = _fromDateFormat('dd');
      case Keys.dateTimeDayDigit: data = _fromDateFormat('d');
      case Keys.dateTimeHoursZero: data = _fromDateFormat('hh');
      // case Keys.dateTimeHours: data = _fromDateFormat('');
      case Keys.dateTimeMinutesZero: data = _fromDateFormat('mm');
      case Keys.dateTimeMinutes: data = _fromDateFormat('m');
      case Keys.dateTimeSecondsZero: data = _fromDateFormat('ss');
      case Keys.dateTimeSeconds: data = _fromDateFormat('s');
      case Keys.dateTimeMilliSeconds3D: data = _fromDateFormat('SSS');
      case Keys.dateTimeMilliSeconds2D: data = _fromDateFormat('SS');
      case Keys.dateTimeMilliSeconds1D: data = _fromDateFormat('S');
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