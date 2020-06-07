import 'package:flutter/foundation.dart';

class DateProvider with ChangeNotifier {
  String date = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day, 12)
          .toIso8601String() +
      'Z';

  getDate(String date) {
    this.date = date;
    notifyListeners();
  }
}
