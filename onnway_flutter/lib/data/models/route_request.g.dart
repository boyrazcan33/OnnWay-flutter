// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteRequestImpl _$$RouteRequestImplFromJson(Map<String, dynamic> json) =>
    _$RouteRequestImpl(
      startLat: (json['startLat'] as num).toDouble(),
      startLon: (json['startLon'] as num).toDouble(),
      city: $enumDecode(_$CityEnumMap, json['city']),
      activity: $enumDecode(_$ActivityTypeEnumMap, json['activity']),
      budget: $enumDecode(_$BudgetRangeEnumMap, json['budget']),
      duration: $enumDecode(_$DurationEnumMap, json['duration']),
    );

Map<String, dynamic> _$$RouteRequestImplToJson(_$RouteRequestImpl instance) =>
    <String, dynamic>{
      'startLat': instance.startLat,
      'startLon': instance.startLon,
      'city': _$CityEnumMap[instance.city]!,
      'activity': _$ActivityTypeEnumMap[instance.activity]!,
      'budget': _$BudgetRangeEnumMap[instance.budget]!,
      'duration': _$DurationEnumMap[instance.duration]!,
    };

const _$CityEnumMap = {City.TALLINN: 'TALLINN', City.ISTANBUL: 'ISTANBUL'};

const _$ActivityTypeEnumMap = {
  ActivityType.FOOD: 'FOOD',
  ActivityType.ART_HISTORY: 'ART_HISTORY',
  ActivityType.SOCIAL_MEDIA: 'SOCIAL_MEDIA',
  ActivityType.ADVENTURE: 'ADVENTURE',
};

const _$BudgetRangeEnumMap = {
  BudgetRange.BUDGET: 'BUDGET',
  BudgetRange.MID_RANGE: 'MID_RANGE',
  BudgetRange.PREMIUM: 'PREMIUM',
};

const _$DurationEnumMap = {
  Duration.SHORT: 'SHORT',
  Duration.MEDIUM: 'MEDIUM',
  Duration.LONG: 'LONG',
};
