// lib/data/models/route_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_response.freezed.dart';
part 'route_response.g.dart';

@freezed
class RouteResponse with _$RouteResponse {
  const factory RouteResponse({
    required List<RouteStop> optimizedRoute,
    required String totalDistance,
    required String totalDuration,
    required double totalCost,
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
}

@freezed
class RouteStop with _$RouteStop {
  const factory RouteStop({
    required int order,
    required String name,
    required String address,
    required String description,
    required int estimatedDuration,
    required String walkingTime,
    required double cost,
  }) = _RouteStop;

  factory RouteStop.fromJson(Map<String, dynamic> json) =>
      _$RouteStopFromJson(json);
}