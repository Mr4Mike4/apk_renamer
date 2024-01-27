class SettingsObj {
  SettingsObj({
    required this.aaptPath,
    required this.template,
    required this.filePaths,
    this.outPath,
    this.countSuffix,
  });

  final String aaptPath;
  final String template;
  final List<String> filePaths;
  final String? outPath;
  final String? countSuffix;
}
