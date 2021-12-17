import 'package:flutter/material.dart';

enum LanguageType {
  // ignore: constant_identifier_names
  ENGLISH,
  // ignore: constant_identifier_names
  TURKISH
}

// ignore: constant_identifier_names
const String TURKISH = 'tr';
// ignore: constant_identifier_names
const String ENGLISH = 'en';
// ignore: constant_identifier_names
const String ASSETS_PATH_LOCALISATIONS = 'assets/translations';
// ignore: constant_identifier_names, non_constant_identifier_names
 Locale TURKISH_LOCALE = const Locale("tr","TR");
// ignore: constant_identifier_names, non_constant_identifier_names
 Locale ENGLISH_LOCALE = const Locale("en","US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;

      case LanguageType.TURKISH:
        return TURKISH;
    }
  }
}
