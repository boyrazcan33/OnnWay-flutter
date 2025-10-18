// lib/data/models/duration.dart
enum Duration {
  SHORT,
  MEDIUM,
  LONG;

  String get displayName {
    switch (this) {
      case Duration.SHORT:
        return 'Short (3-4 hours)';
      case Duration.MEDIUM:
        return 'Medium (1 day)';
      case Duration.LONG:
        return 'Long (2+ days)';
    }
  }
}