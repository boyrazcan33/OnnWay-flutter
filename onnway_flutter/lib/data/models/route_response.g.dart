// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteResponseImpl _$$RouteResponseImplFromJson(Map<String, dynamic> json) =>
    _$RouteResponseImpl(
      optimizedRoute: (json['optimizedRoute'] as List<dynamic>)
          .map((e) => RouteStop.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDistance: json['totalDistance'] as String,
      totalDuration: json['totalDuration'] as String,
      totalCost: (json['totalCost'] as num).toDouble(),
    );

Map<String, dynamic> _$$RouteResponseImplToJson(_$RouteResponseImpl instance) =>
    <String, dynamic>{
      'optimizedRoute': instance.optimizedRoute,
      'totalDistance': instance.totalDistance,
      'totalDuration': instance.totalDuration,
      'totalCost': instance.totalCost,
    };

_$RouteStopImpl _$$RouteStopImplFromJson(Map<String, dynamic> json) =>
    _$RouteStopImpl(
      order: (json['order'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      walkingTime: json['walkingTime'] as String,
      cost: (json['cost'] as num).toDouble(),
    );

Map<String, dynamic> _$$RouteStopImplToJson(_$RouteStopImpl instance) =>
    <String, dynamic>{
      'order': instance.order,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'estimatedDuration': instance.estimatedDuration,
      'walkingTime': instance.walkingTime,
      'cost': instance.cost,
    };
