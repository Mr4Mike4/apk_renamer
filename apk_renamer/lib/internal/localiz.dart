import 'package:apk_renamer/localizations.dart';
import 'package:flutter/widgets.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localiz {
  static String? localeName;

  static Future<AppLocalizations> get l10n {
    const supported = AppLocalizations.supportedLocales;
    Locale loc;
    if(localeName != null){
      loc = supported.firstWhere((e) => e.languageCode == localeName);
    } else {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      final preferred = widgetsBinding.platformDispatcher.locales;
      loc = basicLocaleListResolution(preferred, supported);
    }
    return AppLocalizations.delegate.load(loc);
  }
}