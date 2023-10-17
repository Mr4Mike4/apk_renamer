import 'package:kiwi/kiwi.dart';

import '../data/model/settings_obj.dart';
import '../data/rename_isolate/rename_isolate.dart';
import '../data/repository/preferences_repository.dart';

class AppAssembly {
  static Future<void> init() async {

    PreferencesRepository.init();

    final container = KiwiContainer();
    container
      ..registerSingleton((di) => PreferencesRepository())
      ..registerSingleton((di) => RenameIsolate());

    final renameIsolate = container.resolve<RenameIsolate>();
    final pref = container.resolve<PreferencesRepository>();
    final aaptPath = await pref.getAaptPath();
    if (aaptPath != null) {
      await renameIsolate.init(SettingsObj(
        aaptPath: aaptPath,
      ));
    }
  }
}
