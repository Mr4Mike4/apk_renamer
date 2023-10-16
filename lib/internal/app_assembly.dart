import 'package:kiwi/kiwi.dart';

import '../data/rename_isolate/rename_isolate.dart';
import '../data/repository/preferences_repository.dart';

class AppAssembly {
  static Future<void> init() async {

    PreferencesRepository.init();

    final container = KiwiContainer();
    container
      ..registerSingleton((di) => PreferencesRepository())
      ..registerSingleton((di) => RenameIsolate());
  }
}
