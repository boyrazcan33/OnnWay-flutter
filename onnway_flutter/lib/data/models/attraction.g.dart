// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttractionImpl _$$AttractionImplFromJson(Map<String, dynamic> json) =>
    _$AttractionImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] as String,
      activityType: json['activityType'] as String,
      budgetRange: json['budgetRange'] as String,
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      avgCost: (json['avgCost'] as num).toDouble(),
    );

Map<String, dynamic> _$$AttractionImplToJson(_$AttractionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'activityType': instance.activityType,
      'budgetRange': instance.budgetRange,
      'estimatedDuration': instance.estimatedDuration,
      'avgCost': instance.avgCost,
    };
