// lib/data/models/city.dart
enum City {
  TALLINN,
  ISTANBUL;

  String get displayName {
    switch (this) {
      case City.TALLINN:
        return 'Tallinn';
      case City.ISTANBUL:
        return 'Istanbul';
    }
  }

  String get emoji {
    switch (this) {
      case City.TALLINN:
        return '🇪🇪';
      case City.ISTANBUL:
        return '🇹🇷';
    }
  }
}