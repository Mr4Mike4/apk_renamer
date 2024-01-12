class SettingsObj {
  SettingsObj.init({
    required this.aaptPath,
    required this.countSuffix,
  });

  SettingsObj.update({
    required this.countSuffix,
  }): aaptPath = null;

  final String? aaptPath;
  final String? countSuffix;
}
