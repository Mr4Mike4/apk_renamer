import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class AppTheme {
  AppTheme._();

  static FluentThemeData _getTheme(
    BuildContext context,
    Brightness brightness,
  ) => FluentThemeData(
      brightness: brightness,
      accentColor: SystemTheme.accentColor.accent.toAccentColor(),
      visualDensity: VisualDensity.standard,
      focusTheme: FocusThemeData(
        glowFactor: is10footScreen(context) ? 2.0 : 0.0,
      ),
    );

  static FluentThemeData light(BuildContext context) {

    return _getTheme(context, Brightness.light);
  }

  static FluentThemeData dark(BuildContext context) {

    return _getTheme(context, Brightness.dark);
  }
}
