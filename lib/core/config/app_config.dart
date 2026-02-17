import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseApiUrl {
    if (kIsWeb) {
      return 'http://localhost:5271/api';
    }
    return 'http://10.0.2.2:5271/api';
  }
}