import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:apk_renamer_cli/model/arg_keys.dart';
import 'package:apk_renamer_cli/model/rename_info.dart';
import 'package:apk_renamer_cli/model/settings_obj.dart';
import 'package:apk_renamer_cli/rename_isolate/app_logger.dart';
import 'package:apk_renamer_cli/src/constants/pubspec.yaml.g.dart';
import 'package:args/args.dart';
import 'package:logger/logger.dart' as l;
import 'package:parser_apk_info/repository/aapt_util.dart';
import 'package:path/path.dart' as p;
import 'package:renamer_lib/model/aapt_path_util.dart';
import 'package:renamer_lib/model/file_info.dart';
import 'package:renamer_lib/repository/rename_controller.dart';

const bool kProfileMode = bool.fromEnvironment('dart.vm.profile');
const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');
const bool kDebugMode = !kReleaseMode && !kProfileMode;

Future<List<RenameInfo>> createIsolate(SettingsObj settings) async {
  final renameController = RenameController(AppLogger());

  await renameController.aaptInit(settings.aaptPath);
  renameController.countSuffix = settings.countSuffix;

  final apks = settings.filePaths.where((el) => el.endsWith(AaptUtil.apkExt));

  await renameController.loadApkInfo(apks);

  final listInfo = renameController.listApkInfo.map((e) => FileInfo(
        uuid: e.uuid,
        file: e.file,
        currentFileName: p.basename(e.file.path),
      ));

  final listFileInfo = await renameController.updateFilesInfo(
      List.unmodifiable(listInfo), settings.template);

  final listRenameFileInfo = await renameController
      .renameFilesInfo(listFileInfo, destPath: settings.outPath);

  final resultList = <RenameInfo>[];
  listRenameFileInfo.forEach((el) {
    final old = listInfo.firstWhere((el2) => el2.uuid == el.uuid);
    resultList.add(RenameInfo(
      oldFileName: old.currentFileName,
      newFileName: el.newFileName,
    ));
  });
  return resultList;
}

ArgParser buildParser() {
  return ArgParser()
    ..addOption(
      ArgKeys.template,
      abbr: 't',
      help: 'The file name template',
      valueHelp: 'template',
    )
    ..addOption(ArgKeys.file, help: 'The file', valueHelp: 'app.apk')
    ..addOption(ArgKeys.out, help: 'The output path', valueHelp: 'path')
    ..addOption(
      ArgKeys.countSuffix,
      help: 'The suffix that is added when such a name already exists',
      valueHelp: RenameController.defaultCountSuffix,
    )
    ..addFlag(
      ArgKeys.help,
      help: 'Help',
      defaultsTo: false,
      negatable: false,
    )
    ..addFlag(
      ArgKeys.version,
      help: 'ApkRenamer-cli version',
      defaultsTo: false,
      negatable: false,
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: apk_renamer_cli [flags] [arguments]');
  print(argParser.usage);
}

void _getVersion() {
  final version = Pubspec.version.canonical;
  print('Version: $version');
}

Future<void> main(List<String> arguments) async {
  if (kDebugMode) {
    l.Logger.level = l.Level.trace;
  } else {
    l.Logger.level = l.Level.off;
  }

  final ArgParser argParser = buildParser();
  try {
    final results = argParser.parse(arguments);

    if (results.wasParsed(ArgKeys.help)) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed(ArgKeys.version)) {
      _getVersion();
      return;
    }

    final aaptDirPath = AaptPathUtil.getAaptApp(kDebugMode);
    final aaptPath = await AaptUtil.getAaptApp(aaptDirPath);
    if (aaptPath == null) {
      stderr.writeln("error: aapt2 not found!");
      exit(2);
    }
    final listRenameFileInfo =
        await Isolate.run(() => createIsolate(SettingsObj(
              aaptPath: aaptPath,
              template: results[ArgKeys.template],
              countSuffix: results[ArgKeys.countSuffix],
              filePaths: [
                results[ArgKeys.file],
              ],
              outPath: results[ArgKeys.out],
            )));
    listRenameFileInfo.forEach((el) {
      print("${el.oldFileName} ==>>> ${el.newFileName}");
    });
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
