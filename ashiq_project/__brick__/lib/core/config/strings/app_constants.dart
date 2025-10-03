import 'dart:ui';

class AppConstants {
  static const int defaultTimeoutSec = 30; // in milliseconds

  static const Locale fallbackLocale = Locale('en', 'US');
  static const Map<String, Locale> supportedLocales = {
    'English': Locale('en', 'US'),
    'العربية': Locale('ar', 'EG'),
  };
  static const String translationPath = 'assets/translations';
}
