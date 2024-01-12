class SettingsObj {
  SettingsObj({
    required this.aaptPath,
    required this.pattern,
    required this.filePaths,
    this.outPath,
    this.countSuffix,
  });

  final String aaptPath;
  final String pattern;
  final List<String> filePaths;
  final String? outPath;
  final String? countSuffix;
}
