import 'package:apk_renamer/presentation/views/apk_list_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:system_theme/system_theme.dart';

import '../localizations.dart';
import '../presentation/views/home_page.dart';
import '../presentation/views/settings_page.dart';

part 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Window.setEffect(
    //   effect: WindowEffect.solid,
    //   color: FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05),
    //   dark: FluentTheme.of(context).brightness.isDark,
    // );
    return FluentApp.router(
      title: 'ApkRenamer',
      theme: FluentThemeData(
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('ru'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationPaneTheme(
            data: const NavigationPaneThemeData(
              backgroundColor: null,
            ),
            child: child!,
          ),
        );
      },
    );
  }
}
