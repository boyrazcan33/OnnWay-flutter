// lib/data/models/activity_type.dart
enum ActivityType {
  FOOD,
  ART_HISTORY,
  SOCIAL_MEDIA,
  ADVENTURE;

  String get displayName {
    switch (this) {
      case ActivityType.FOOD:
        return 'Food & Restaurants';
      case ActivityType.ART_HISTORY:
        return 'Art & History';
      case ActivityType.SOCIAL_MEDIA:
        return 'Social Media Spots';
      case ActivityType.ADVENTURE:
        return 'Adventure';
    }
  }
}