// lib/data/models/route_request.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'city.dart';
import 'activity_type.dart';
import 'budget_range.dart';
import 'duration.dart';

part 'route_request.freezed.dart';
part 'route_request.g.dart';

@freezed
class RouteRequest with _$RouteRequest {
  const factory RouteRequest({
    required double startLat,
    required double startLon,
    required City city,
    required ActivityType activity,
    required BudgetRange budget,
    required Duration duration,
  }) = _RouteRequest;

  factory RouteRequest.fromJson(Map<String, dynamic> json) =>
      _$RouteRequestFromJson(json);
}