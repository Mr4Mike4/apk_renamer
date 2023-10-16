import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'internal/app_assembly.dart';
import 'internal/application.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  await AppAssembly.init();

  if (isDesktop) {
    // await flutter_acrylic.Window.initialize();
    // await flutter_acrylic.Window.hideWindowControls();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(500, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());

  // Future.wait([
  //   DeferredWidget.preload(popups.loadLibrary),
  //   DeferredWidget.preload(forms.loadLibrary),
  //   DeferredWidget.preload(inputs.loadLibrary),
  //   DeferredWidget.preload(navigation.loadLibrary),
  //   DeferredWidget.preload(surfaces.loadLibrary),
  //   DeferredWidget.preload(theming.loadLibrary),
  // ]);
}
