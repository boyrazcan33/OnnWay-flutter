// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) {
  return _RouteResponse.fromJson(json);
}

/// @nodoc
mixin _$RouteResponse {
  List<RouteStop> get optimizedRoute => throw _privateConstructorUsedError;
  String get totalDistance => throw _privateConstructorUsedError;
  String get totalDuration => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;

  /// Serializes this RouteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteResponseCopyWith<RouteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteResponseCopyWith<$Res> {
  factory $RouteResponseCopyWith(
    RouteResponse value,
    $Res Function(RouteResponse) then,
  ) = _$RouteResponseCopyWithImpl<$Res, RouteResponse>;
  @useResult
  $Res call({
    List<RouteStop> optimizedRoute,
    String totalDistance,
    String totalDuration,
    double totalCost,
  });
}

/// @nodoc
class _$RouteResponseCopyWithImpl<$Res, $Val extends RouteResponse>
    implements $RouteResponseCopyWith<$Res> {
  _$RouteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optimizedRoute = null,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? totalCost = null,
  }) {
    return _then(
      _value.copyWith(
            optimizedRoute: null == optimizedRoute
                ? _value.optimizedRoute
                : optimizedRoute // ignore: cast_nullable_to_non_nullable
                      as List<RouteStop>,
            totalDistance: null == totalDistance
                ? _value.totalDistance
                : totalDistance // ignore: cast_nullable_to_non_nullable
                      as String,
            totalDuration: null == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            totalCost: null == totalCost
                ? _value.totalCost
                : totalCost // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteResponseImplCopyWith<$Res>
    implements $RouteResponseCopyWith<$Res> {
  factory _$$RouteResponseImplCopyWith(
    _$RouteResponseImpl value,
    $Res Function(_$RouteResponseImpl) then,
  ) = __$$RouteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RouteStop> optimizedRoute,
    String totalDistance,
    String totalDuration,
    double totalCost,
  });
}

/// @nodoc
class __$$RouteResponseImplCopyWithImpl<$Res>
    extends _$RouteResponseCopyWithImpl<$Res, _$RouteResponseImpl>
    implements _$$RouteResponseImplCopyWith<$Res> {
  __$$RouteResponseImplCopyWithImpl(
    _$RouteResponseImpl _value,
    $Res Function(_$RouteResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? optimizedRoute = null,
    Object? totalDistance = null,
    Object? totalDuration = null,
    Object? totalCost = null,
  }) {
    return _then(
      _$RouteResponseImpl(
        optimizedRoute: null == optimizedRoute
            ? _value._optimizedRoute
            : optimizedRoute // ignore: cast_nullable_to_non_nullable
                  as List<RouteStop>,
        totalDistance: null == totalDistance
            ? _value.totalDistance
            : totalDistance // ignore: cast_nullable_to_non_nullable
                  as String,
        totalDuration: null == totalDuration
            ? _value.totalDuration
            : totalDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        totalCost: null == totalCost
            ? _value.totalCost
            : totalCost // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteResponseImpl implements _RouteResponse {
  const _$RouteResponseImpl({
    required final List<RouteStop> optimizedRoute,
    required this.totalDistance,
    required this.totalDuration,
    required this.totalCost,
  }) : _optimizedRoute = optimizedRoute;

  factory _$RouteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteResponseImplFromJson(json);

  final List<RouteStop> _optimizedRoute;
  @override
  List<RouteStop> get optimizedRoute {
    if (_optimizedRoute is EqualUnmodifiableListView) return _optimizedRoute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optimizedRoute);
  }

  @override
  final String totalDistance;
  @override
  final String totalDuration;
  @override
  final double totalCost;

  @override
  String toString() {
    return 'RouteResponse(optimizedRoute: $optimizedRoute, totalDistance: $totalDistance, totalDuration: $totalDuration, totalCost: $totalCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteResponseImpl &&
            const DeepCollectionEquality().equals(
              other._optimizedRoute,
              _optimizedRoute,
            ) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_optimizedRoute),
    totalDistance,
    totalDuration,
    totalCost,
  );

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteResponseImplCopyWith<_$RouteResponseImpl> get copyWith =>
      __$$RouteResponseImplCopyWithImpl<_$RouteResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteResponseImplToJson(this);
  }
}

abstract class _RouteResponse implements RouteResponse {
  const factory _RouteResponse({
    required final List<RouteStop> optimizedRoute,
    required final String totalDistance,
    required final String totalDuration,
    required final double totalCost,
  }) = _$RouteResponseImpl;

  factory _RouteResponse.fromJson(Map<String, dynamic> json) =
      _$RouteResponseImpl.fromJson;

  @override
  List<RouteStop> get optimizedRoute;
  @override
  String get totalDistance;
  @override
  String get totalDuration;
  @override
  double get totalCost;

  /// Create a copy of RouteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteResponseImplCopyWith<_$RouteResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteStop _$RouteStopFromJson(Map<String, dynamic> json) {
  return _RouteStop.fromJson(json);
}

/// @nodoc
mixin _$RouteStop {
  int get order => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get estimatedDuration => throw _privateConstructorUsedError;
  String get walkingTime => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;

  /// Serializes this RouteStop to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteStop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteStopCopyWith<RouteStop> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteStopCopyWith<$Res> {
  factory $RouteStopCopyWith(RouteStop value, $Res Function(RouteStop) then) =
      _$RouteStopCopyWithImpl<$Res, RouteStop>;
  @useResult
  $Res call({
    int order,
    String name,
    String address,
    String description,
    int estimatedDuration,
    String walkingTime,
    double cost,
  });
}

/// @nodoc
class _$RouteStopCopyWithImpl<$Res, $Val extends RouteStop>
    implements $RouteStopCopyWith<$Res> {
  _$RouteStopCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteStop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? name = null,
    Object? address = null,
    Object? description = null,
    Object? estimatedDuration = null,
    Object? walkingTime = null,
    Object? cost = null,
  }) {
    return _then(
      _value.copyWith(
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedDuration: null == estimatedDuration
                ? _value.estimatedDuration
                : estimatedDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            walkingTime: null == walkingTime
                ? _value.walkingTime
                : walkingTime // ignore: cast_nullable_to_non_nullable
                      as String,
            cost: null == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteStopImplCopyWith<$Res>
    implements $RouteStopCopyWith<$Res> {
  factory _$$RouteStopImplCopyWith(
    _$RouteStopImpl value,
    $Res Function(_$RouteStopImpl) then,
  ) = __$$RouteStopImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int order,
    String name,
    String address,
    String description,
    int estimatedDuration,
    String walkingTime,
    double cost,
  });
}

/// @nodoc
class __$$RouteStopImplCopyWithImpl<$Res>
    extends _$RouteStopCopyWithImpl<$Res, _$RouteStopImpl>
    implements _$$RouteStopImplCopyWith<$Res> {
  __$$RouteStopImplCopyWithImpl(
    _$RouteStopImpl _value,
    $Res Function(_$RouteStopImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteStop
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? name = null,
    Object? address = null,
    Object? description = null,
    Object? estimatedDuration = null,
    Object? walkingTime = null,
    Object? cost = null,
  }) {
    return _then(
      _$RouteStopImpl(
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedDuration: null == estimatedDuration
            ? _value.estimatedDuration
            : estimatedDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        walkingTime: null == walkingTime
            ? _value.walkingTime
            : walkingTime // ignore: cast_nullable_to_non_nullable
                  as String,
        cost: null == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteStopImpl implements _RouteStop {
  const _$RouteStopImpl({
    required this.order,
    required this.name,
    required this.address,
    required this.description,
    required this.estimatedDuration,
    required this.walkingTime,
    required this.cost,
  });

  factory _$RouteStopImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteStopImplFromJson(json);

  @override
  final int order;
  @override
  final String name;
  @override
  final String address;
  @override
  final String description;
  @override
  final int estimatedDuration;
  @override
  final String walkingTime;
  @override
  final double cost;

  @override
  String toString() {
    return 'RouteStop(order: $order, name: $name, address: $address, description: $description, estimatedDuration: $estimatedDuration, walkingTime: $walkingTime, cost: $cost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteStopImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.walkingTime, walkingTime) ||
                other.walkingTime == walkingTime) &&
            (identical(other.cost, cost) || other.cost == cost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    order,
    name,
    address,
    description,
    estimatedDuration,
    walkingTime,
    cost,
  );

  /// Create a copy of RouteStop
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteStopImplCopyWith<_$RouteStopImpl> get copyWith =>
      __$$RouteStopImplCopyWithImpl<_$RouteStopImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteStopImplToJson(this);
  }
}

abstract class _RouteStop implements RouteStop {
  const factory _RouteStop({
    required final int order,
    required final String name,
    required final String address,
    required final String description,
    required final int estimatedDuration,
    required final String walkingTime,
    required final double cost,
  }) = _$RouteStopImpl;

  factory _RouteStop.fromJson(Map<String, dynamic> json) =
      _$RouteStopImpl.fromJson;

  @override
  int get order;
  @override
  String get name;
  @override
  String get address;
  @override
  String get description;
  @override
  int get estimatedDuration;
  @override
  String get walkingTime;
  @override
  double get cost;

  /// Create a copy of RouteStop
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteStopImplCopyWith<_$RouteStopImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
