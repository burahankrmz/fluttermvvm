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
