// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RouteRequest _$RouteRequestFromJson(Map<String, dynamic> json) {
  return _RouteRequest.fromJson(json);
}

/// @nodoc
mixin _$RouteRequest {
  double get startLat => throw _privateConstructorUsedError;
  double get startLon => throw _privateConstructorUsedError;
  City get city => throw _privateConstructorUsedError;
  ActivityType get activity => throw _privateConstructorUsedError;
  BudgetRange get budget => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;

  /// Serializes this RouteRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteRequestCopyWith<RouteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteRequestCopyWith<$Res> {
  factory $RouteRequestCopyWith(
    RouteRequest value,
    $Res Function(RouteRequest) then,
  ) = _$RouteRequestCopyWithImpl<$Res, RouteRequest>;
  @useResult
  $Res call({
    double startLat,
    double startLon,
    City city,
    ActivityType activity,
    BudgetRange budget,
    Duration duration,
  });
}

/// @nodoc
class _$RouteRequestCopyWithImpl<$Res, $Val extends RouteRequest>
    implements $RouteRequestCopyWith<$Res> {
  _$RouteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startLat = null,
    Object? startLon = null,
    Object? city = null,
    Object? activity = null,
    Object? budget = null,
    Object? duration = null,
  }) {
    return _then(
      _value.copyWith(
            startLat: null == startLat
                ? _value.startLat
                : startLat // ignore: cast_nullable_to_non_nullable
                      as double,
            startLon: null == startLon
                ? _value.startLon
                : startLon // ignore: cast_nullable_to_non_nullable
                      as double,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as City,
            activity: null == activity
                ? _value.activity
                : activity // ignore: cast_nullable_to_non_nullable
                      as ActivityType,
            budget: null == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as BudgetRange,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteRequestImplCopyWith<$Res>
    implements $RouteRequestCopyWith<$Res> {
  factory _$$RouteRequestImplCopyWith(
    _$RouteRequestImpl value,
    $Res Function(_$RouteRequestImpl) then,
  ) = __$$RouteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double startLat,
    double startLon,
    City city,
    ActivityType activity,
    BudgetRange budget,
    Duration duration,
  });
}

/// @nodoc
class __$$RouteRequestImplCopyWithImpl<$Res>
    extends _$RouteRequestCopyWithImpl<$Res, _$RouteRequestImpl>
    implements _$$RouteRequestImplCopyWith<$Res> {
  __$$RouteRequestImplCopyWithImpl(
    _$RouteRequestImpl _value,
    $Res Function(_$RouteRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startLat = null,
    Object? startLon = null,
    Object? city = null,
    Object? activity = null,
    Object? budget = null,
    Object? duration = null,
  }) {
    return _then(
      _$RouteRequestImpl(
        startLat: null == startLat
            ? _value.startLat
            : startLat // ignore: cast_nullable_to_non_nullable
                  as double,
        startLon: null == startLon
            ? _value.startLon
            : startLon // ignore: cast_nullable_to_non_nullable
                  as double,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as City,
        activity: null == activity
            ? _value.activity
            : activity // ignore: cast_nullable_to_non_nullable
                  as ActivityType,
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as BudgetRange,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteRequestImpl implements _RouteRequest {
  const _$RouteRequestImpl({
    required this.startLat,
    required this.startLon,
    required this.city,
    required this.activity,
    required this.budget,
    required this.duration,
  });

  factory _$RouteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteRequestImplFromJson(json);

  @override
  final double startLat;
  @override
  final double startLon;
  @override
  final City city;
  @override
  final ActivityType activity;
  @override
  final BudgetRange budget;
  @override
  final Duration duration;

  @override
  String toString() {
    return 'RouteRequest(startLat: $startLat, startLon: $startLon, city: $city, activity: $activity, budget: $budget, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteRequestImpl &&
            (identical(other.startLat, startLat) ||
                other.startLat == startLat) &&
            (identical(other.startLon, startLon) ||
                other.startLon == startLon) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.activity, activity) ||
                other.activity == activity) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startLat,
    startLon,
    city,
    activity,
    budget,
    duration,
  );

  /// Create a copy of RouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteRequestImplCopyWith<_$RouteRequestImpl> get copyWith =>
      __$$RouteRequestImplCopyWithImpl<_$RouteRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteRequestImplToJson(this);
  }
}

abstract class _RouteRequest implements RouteRequest {
  const factory _RouteRequest({
    required final double startLat,
    required final double startLon,
    required final City city,
    required final ActivityType activity,
    required final BudgetRange budget,
    required final Duration duration,
  }) = _$RouteRequestImpl;

  factory _RouteRequest.fromJson(Map<String, dynamic> json) =
      _$RouteRequestImpl.fromJson;

  @override
  double get startLat;
  @override
  double get startLon;
  @override
  City get city;
  @override
  ActivityType get activity;
  @override
  BudgetRange get budget;
  @override
  Duration get duration;

  /// Create a copy of RouteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteRequestImplCopyWith<_$RouteRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
