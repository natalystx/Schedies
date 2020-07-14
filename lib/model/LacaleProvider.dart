import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale locale = Locale('en', 'US');

  setLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}
