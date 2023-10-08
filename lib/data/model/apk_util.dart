import 'apk_info.dart';
import 'keys.dart';

class ApkUtil {
  static String fromApkInfo(final String? apkKey, final ApkInfo? apkInfo) {
    String? data;
    switch(apkKey){
      case Keys.apkApplicationId: data = apkInfo?.applicationId;
      case Keys.apkVersionCode: data = apkInfo?.versionCode;
      case Keys.apkVersionName: data = apkInfo?.versionName;
      case Keys.apkPlatformBuildVersionName: data = apkInfo?.platformBuildVersionName;
      case Keys.apkPlatformBuildVersionCode: data = apkInfo?.platformBuildVersionCode;
      case Keys.apkCompileSdkVersion: data = apkInfo?.compileSdkVersion;
      case Keys.apkCompileSdkVersionCodename: data = apkInfo?.compileSdkVersionCodename;
      case Keys.apkSdkVersion: data = apkInfo?.sdkVersion;
      case Keys.apkTargetSdkVersion: data = apkInfo?.targetSdkVersion;
      case Keys.apkApplicationLabel: data = apkInfo?.applicationLabel;
    }
    return data ?? '';
  }
}