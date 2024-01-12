import 'package:apk_renamer/localizations.dart';
import 'package:flutter/widgets.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localiz {

  static Future<AppLocalizations> get l10n {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    final preferred = widgetsBinding.platformDispatcher.locales;
    const supported = AppLocalizations.supportedLocales;
    final locale = basicLocaleListResolution(preferred, supported);
    return AppLocalizations.delegate.load(locale);
  }
}