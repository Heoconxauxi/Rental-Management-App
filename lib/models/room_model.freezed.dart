// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get buildingId => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get roomType => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;
  int get basePrice => throw _privateConstructorUsedError;
  int get depositAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get maxOccupants => throw _privateConstructorUsedError;
  int get floor => throw _privateConstructorUsedError;
  Map<String, bool> get amenities => throw _privateConstructorUsedError;
  String? get currentTenantId => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String id,
    String buildingId,
    String roomNumber,
    String roomType,
    double area,
    int basePrice,
    int depositAmount,
    String status,
    int maxOccupants,
    int floor,
    Map<String, bool> amenities,
    String? currentTenantId,
  });
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buildingId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? area = null,
    Object? basePrice = null,
    Object? depositAmount = null,
    Object? status = null,
    Object? maxOccupants = null,
    Object? floor = null,
    Object? amenities = null,
    Object? currentTenantId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            buildingId:
                null == buildingId
                    ? _value.buildingId
                    : buildingId // ignore: cast_nullable_to_non_nullable
                        as String,
            roomNumber:
                null == roomNumber
                    ? _value.roomNumber
                    : roomNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            roomType:
                null == roomType
                    ? _value.roomType
                    : roomType // ignore: cast_nullable_to_non_nullable
                        as String,
            area:
                null == area
                    ? _value.area
                    : area // ignore: cast_nullable_to_non_nullable
                        as double,
            basePrice:
                null == basePrice
                    ? _value.basePrice
                    : basePrice // ignore: cast_nullable_to_non_nullable
                        as int,
            depositAmount:
                null == depositAmount
                    ? _value.depositAmount
                    : depositAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            maxOccupants:
                null == maxOccupants
                    ? _value.maxOccupants
                    : maxOccupants // ignore: cast_nullable_to_non_nullable
                        as int,
            floor:
                null == floor
                    ? _value.floor
                    : floor // ignore: cast_nullable_to_non_nullable
                        as int,
            amenities:
                null == amenities
                    ? _value.amenities
                    : amenities // ignore: cast_nullable_to_non_nullable
                        as Map<String, bool>,
            currentTenantId:
                freezed == currentTenantId
                    ? _value.currentTenantId
                    : currentTenantId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String buildingId,
    String roomNumber,
    String roomType,
    double area,
    int basePrice,
    int depositAmount,
    String status,
    int maxOccupants,
    int floor,
    Map<String, bool> amenities,
    String? currentTenantId,
  });
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? buildingId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? area = null,
    Object? basePrice = null,
    Object? depositAmount = null,
    Object? status = null,
    Object? maxOccupants = null,
    Object? floor = null,
    Object? amenities = null,
    Object? currentTenantId = freezed,
  }) {
    return _then(
      _$RoomImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        buildingId:
            null == buildingId
                ? _value.buildingId
                : buildingId // ignore: cast_nullable_to_non_nullable
                    as String,
        roomNumber:
            null == roomNumber
                ? _value.roomNumber
                : roomNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        roomType:
            null == roomType
                ? _value.roomType
                : roomType // ignore: cast_nullable_to_non_nullable
                    as String,
        area:
            null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                    as double,
        basePrice:
            null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                    as int,
        depositAmount:
            null == depositAmount
                ? _value.depositAmount
                : depositAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        maxOccupants:
            null == maxOccupants
                ? _value.maxOccupants
                : maxOccupants // ignore: cast_nullable_to_non_nullable
                    as int,
        floor:
            null == floor
                ? _value.floor
                : floor // ignore: cast_nullable_to_non_nullable
                    as int,
        amenities:
            null == amenities
                ? _value._amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                    as Map<String, bool>,
        currentTenantId:
            freezed == currentTenantId
                ? _value.currentTenantId
                : currentTenantId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.buildingId,
    required this.roomNumber,
    required this.roomType,
    required this.area,
    required this.basePrice,
    required this.depositAmount,
    required this.status,
    required this.maxOccupants,
    required this.floor,
    required final Map<String, bool> amenities,
    this.currentTenantId,
  }) : _amenities = amenities;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String buildingId;
  @override
  final String roomNumber;
  @override
  final String roomType;
  @override
  final double area;
  @override
  final int basePrice;
  @override
  final int depositAmount;
  @override
  final String status;
  @override
  final int maxOccupants;
  @override
  final int floor;
  final Map<String, bool> _amenities;
  @override
  Map<String, bool> get amenities {
    if (_amenities is EqualUnmodifiableMapView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_amenities);
  }

  @override
  final String? currentTenantId;

  @override
  String toString() {
    return 'Room(id: $id, buildingId: $buildingId, roomNumber: $roomNumber, roomType: $roomType, area: $area, basePrice: $basePrice, depositAmount: $depositAmount, status: $status, maxOccupants: $maxOccupants, floor: $floor, amenities: $amenities, currentTenantId: $currentTenantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.buildingId, buildingId) ||
                other.buildingId == buildingId) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.depositAmount, depositAmount) ||
                other.depositAmount == depositAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxOccupants, maxOccupants) ||
                other.maxOccupants == maxOccupants) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            (identical(other.currentTenantId, currentTenantId) ||
                other.currentTenantId == currentTenantId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    buildingId,
    roomNumber,
    roomType,
    area,
    basePrice,
    depositAmount,
    status,
    maxOccupants,
    floor,
    const DeepCollectionEquality().hash(_amenities),
    currentTenantId,
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final String id,
    required final String buildingId,
    required final String roomNumber,
    required final String roomType,
    required final double area,
    required final int basePrice,
    required final int depositAmount,
    required final String status,
    required final int maxOccupants,
    required final int floor,
    required final Map<String, bool> amenities,
    final String? currentTenantId,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get buildingId;
  @override
  String get roomNumber;
  @override
  String get roomType;
  @override
  double get area;
  @override
  int get basePrice;
  @override
  int get depositAmount;
  @override
  String get status;
  @override
  int get maxOccupants;
  @override
  int get floor;
  @override
  Map<String, bool> get amenities;
  @override
  String? get currentTenantId;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
