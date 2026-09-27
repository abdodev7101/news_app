
import 'package:flutter/material.dart';

import 'l10n/ar_translations.dart';
import 'l10n/en_translations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  // الدالة دي دلوقتي مبقتش Future ولا بتستخدم rootBundle
  // بقت بتحمل الداتا من ملفات الـ Dart مباشرة
  void load() {
    if (locale.languageCode == 'ar') {
      _localizedStrings = arTranslations;
    } else {
      _localizedStrings = enTranslations;
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    // استدعاء الـ load العادية لأنها مفيهاش await خلاص
    localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

// إضافة Extension لتسهيل الكتابة في الـ UI
extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return AppLocalizations.of(this)?.translate(key) ?? key;
  }
}