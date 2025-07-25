// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'building_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return _Building.fromJson(json);
}

/// @nodoc
mixin _$Building {
  String get id => throw _privateConstructorUsedError;
  String get buildingName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get totalRooms => throw _privateConstructorUsedError;
  String get managerId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this Building to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuildingCopyWith<Building> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildingCopyWith<$Res> {
  factory $BuildingCopyWith(Building value, $Res Function(Building) then) =
      _$BuildingCopyWithImpl<$Res, Building>;
  @useResult
  $Res call({
    String id,
    String buildingName,
    String address,
    int totalRooms,
    String managerId,
    String status,
  });
}

/// @nodoc
class _$BuildingCopyWithImpl<$Res, $Val extends Building>
    implements $BuildingCopyWith<$Res> {
  _$BuildingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buildingName = null,
    Object? address = null,
    Object? totalRooms = null,
    Object? managerId = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            buildingName:
                null == buildingName
                    ? _value.buildingName
                    : buildingName // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            totalRooms:
                null == totalRooms
                    ? _value.totalRooms
                    : totalRooms // ignore: cast_nullable_to_non_nullable
                        as int,
            managerId:
                null == managerId
                    ? _value.managerId
                    : managerId // ignore: cast_nullable_to_non_nullable
                        as String,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BuildingImplCopyWith<$Res>
    implements $BuildingCopyWith<$Res> {
  factory _$$BuildingImplCopyWith(
    _$BuildingImpl value,
    $Res Function(_$BuildingImpl) then,
  ) = __$$BuildingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String buildingName,
    String address,
    int totalRooms,
    String managerId,
    String status,
  });
}

/// @nodoc
class __$$BuildingImplCopyWithImpl<$Res>
    extends _$BuildingCopyWithImpl<$Res, _$BuildingImpl>
    implements _$$BuildingImplCopyWith<$Res> {
  __$$BuildingImplCopyWithImpl(
    _$BuildingImpl _value,
    $Res Function(_$BuildingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buildingName = null,
    Object? address = null,
    Object? totalRooms = null,
    Object? managerId = null,
    Object? status = null,
  }) {
    return _then(
      _$BuildingImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        buildingName:
            null == buildingName
                ? _value.buildingName
                : buildingName // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        totalRooms:
            null == totalRooms
                ? _value.totalRooms
                : totalRooms // ignore: cast_nullable_to_non_nullable
                    as int,
        managerId:
            null == managerId
                ? _value.managerId
                : managerId // ignore: cast_nullable_to_non_nullable
                    as String,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BuildingImpl implements _Building {
  const _$BuildingImpl({
    required this.id,
    required this.buildingName,
    required this.address,
    required this.totalRooms,
    required this.managerId,
    required this.status,
  });

  factory _$BuildingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuildingImplFromJson(json);

  @override
  final String id;
  @override
  final String buildingName;
  @override
  final String address;
  @override
  final int totalRooms;
  @override
  final String managerId;
  @override
  final String status;

  @override
  String toString() {
    return 'Building(id: $id, buildingName: $buildingName, address: $address, totalRooms: $totalRooms, managerId: $managerId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.totalRooms, totalRooms) ||
                other.totalRooms == totalRooms) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    buildingName,
    address,
    totalRooms,
    managerId,
    status,
  );

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildingImplCopyWith<_$BuildingImpl> get copyWith =>
      __$$BuildingImplCopyWithImpl<_$BuildingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuildingImplToJson(this);
  }
}

abstract class _Building implements Building {
  const factory _Building({
    required final String id,
    required final String buildingName,
    required final String address,
    required final int totalRooms,
    required final String managerId,
    required final String status,
  }) = _$BuildingImpl;

  factory _Building.fromJson(Map<String, dynamic> json) =
      _$BuildingImpl.fromJson;

  @override
  String get id;
  @override
  String get buildingName;
  @override
  String get address;
  @override
  int get totalRooms;
  @override
  String get managerId;
  @override
  String get status;

  /// Create a copy of Building
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuildingImplCopyWith<_$BuildingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
