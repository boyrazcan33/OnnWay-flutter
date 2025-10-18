// lib/data/models/attraction.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attraction.freezed.dart';
part 'attraction.g.dart';

@freezed
class Attraction with _$Attraction {
  const factory Attraction({
    required int id,
    required String name,
    required String address,
    required String description,
    required double latitude,
    required double longitude,
    required String city,
    required String activityType,
    required String budgetRange,
    required int estimatedDuration,
    required double avgCost,
  }) = _Attraction;

  factory Attraction.fromJson(Map<String, dynamic> json) =>
      _$AttractionFromJson(json);
}