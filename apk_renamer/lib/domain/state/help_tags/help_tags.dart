import 'package:parser_apk_info/model/apk_keys.dart';
import 'package:renamer_lib/model/keys.dart';

import '../../../internal/localiz.dart';
import '../../model/tag_info.dart';

class HelpTags {

  List<TagInfo>? _dateTimeHelp;
  List<TagInfo>? get dateTimeHelp => _dateTimeHelp;

  List<TagInfo>? _apkHelp;
  List<TagInfo>? get apkHelp => _apkHelp;

  void init(AppLocalizations S){
    final dateTimeList = <TagInfo>[];
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_full_year, Keys.dateTimeFullYear));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_year_last_two_digits, Keys.dateTimeYearLastTwoDigits));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_month_name, Keys.dateTimeMonthName));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_month_digit_zero, Keys.dateTimeMonthDigitZero));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_month_digit, Keys.dateTimeMonthDigit));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_day_digit_zero, Keys.dateTimeDayDigitZero));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_day_digit, Keys.dateTimeDayDigit));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_hours_zero, Keys.dateTimeHoursZero));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_minutes_zero, Keys.dateTimeMinutesZero));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_minutes, Keys.dateTimeMinutes));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_seconds_zero, Keys.dateTimeSecondsZero));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_seconds, Keys.dateTimeSeconds));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_milli_seconds_3d, Keys.dateTimeMilliSeconds3D));
    dateTimeList.add(_getDateTimeHelpItem(S.tag_date_time_milli_seconds_1d, Keys.dateTimeMilliSeconds1D));
    _dateTimeHelp = List.unmodifiable(dateTimeList);
    final apkList = <TagInfo>[];
    apkList.add(_getApkHelpItem(S.tag_orig_name, Keys.origName));
    apkList.add(_getApkHelpItem(S.tag_apk_application_label, ApkKeys.apkApplicationLabel));
    apkList.add(_getApkHelpItem(S.tag_apk_application_id, ApkKeys.apkApplicationId));
    apkList.add(_getApkHelpItem(S.tag_apk_version_code, ApkKeys.apkVersionCode));
    apkList.add(_getApkHelpItem(S.tag_apk_version_name, ApkKeys.apkVersionName));
    apkList.add(_getApkHelpItem(S.tag_apk_platform_build_version_name, ApkKeys.apkPlatformBuildVersionName));
    apkList.add(_getApkHelpItem(S.tag_apk_platform_build_version_code, ApkKeys.apkPlatformBuildVersionCode));
    apkList.add(_getApkHelpItem(S.tag_apk_compile_sdk_version, ApkKeys.apkCompileSdkVersion));
    apkList.add(_getApkHelpItem(S.tag_apk_compile_sdk_version_codename, ApkKeys.apkCompileSdkVersionCodename));
    apkList.add(_getApkHelpItem(S.tag_apk_sdk_version, ApkKeys.apkMinSdkVersion));
    apkList.add(_getApkHelpItem(S.tag_apk_target_sdk_version, ApkKeys.apkTargetSdkVersion));
    // apkList.add(_getApkHelpItem(S., ApkKeys.apkApplicationLabels));
    _apkHelp = List.unmodifiable(apkList);
  }

  TagInfo _getDateTimeHelpItem(String text, String tag) {
    return TagInfo(
      text: text,
      tag: '\${$tag}',
    );
  }

  TagInfo _getApkHelpItem(String text, String tag) {
    return TagInfo(
      text: text,
      tag: '\${${Tags.apk}.$tag}',
    );
  }
}