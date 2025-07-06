// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Contract _$ContractFromJson(Map<String, dynamic> json) {
  return _Contract.fromJson(json);
}

/// @nodoc
mixin _$Contract {
  String get id => throw _privateConstructorUsedError;
  String get contractNumber => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get buildingId => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  int get monthlyRent => throw _privateConstructorUsedError;
  int get depositPaid => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this Contract to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Contract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContractCopyWith<Contract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractCopyWith<$Res> {
  factory $ContractCopyWith(Contract value, $Res Function(Contract) then) =
      _$ContractCopyWithImpl<$Res, Contract>;
  @useResult
  $Res call({
    String id,
    String contractNumber,
    String roomId,
    String tenantId,
    String buildingId,
    String startDate,
    String endDate,
    int monthlyRent,
    int depositPaid,
    String status,
    String createdBy,
  });
}

/// @nodoc
class _$ContractCopyWithImpl<$Res, $Val extends Contract>
    implements $ContractCopyWith<$Res> {
  _$ContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractNumber = null,
    Object? roomId = null,
    Object? tenantId = null,
    Object? buildingId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? monthlyRent = null,
    Object? depositPaid = null,
    Object? status = null,
    Object? createdBy = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            contractNumber:
                null == contractNumber
                    ? _value.contractNumber
                    : contractNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            roomId:
                null == roomId
                    ? _value.roomId
                    : roomId // ignore: cast_nullable_to_non_nullable
                        as String,
            tenantId:
                null == tenantId
                    ? _value.tenantId
                    : tenantId // ignore: cast_nullable_to_non_nullable
                        as String,
            buildingId:
                null == buildingId
                    ? _value.buildingId
                    : buildingId // ignore: cast_nullable_to_non_nullable
                        as String,
            startDate:
                null == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as String,
            endDate:
                null == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as String,
            monthlyRent:
                null == monthlyRent
                    ? _value.monthlyRent
                    : monthlyRent // ignore: cast_nullable_to_non_nullable
                        as int,
            depositPaid:
                null == depositPaid
                    ? _value.depositPaid
                    : depositPaid // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            createdBy:
                null == createdBy
                    ? _value.createdBy
                    : createdBy // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContractImplCopyWith<$Res>
    implements $ContractCopyWith<$Res> {
  factory _$$ContractImplCopyWith(
    _$ContractImpl value,
    $Res Function(_$ContractImpl) then,
  ) = __$$ContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String contractNumber,
    String roomId,
    String tenantId,
    String buildingId,
    String startDate,
    String endDate,
    int monthlyRent,
    int depositPaid,
    String status,
    String createdBy,
  });
}

/// @nodoc
class __$$ContractImplCopyWithImpl<$Res>
    extends _$ContractCopyWithImpl<$Res, _$ContractImpl>
    implements _$$ContractImplCopyWith<$Res> {
  __$$ContractImplCopyWithImpl(
    _$ContractImpl _value,
    $Res Function(_$ContractImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Contract
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractNumber = null,
    Object? roomId = null,
    Object? tenantId = null,
    Object? buildingId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? monthlyRent = null,
    Object? depositPaid = null,
    Object? status = null,
    Object? createdBy = null,
  }) {
    return _then(
      _$ContractImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        contractNumber:
            null == contractNumber
                ? _value.contractNumber
                : contractNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        roomId:
            null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                    as String,
        tenantId:
            null == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                    as String,
        buildingId:
            null == buildingId
                ? _value.buildingId
                : buildingId // ignore: cast_nullable_to_non_nullable
                    as String,
        startDate:
            null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as String,
        endDate:
            null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as String,
        monthlyRent:
            null == monthlyRent
                ? _value.monthlyRent
                : monthlyRent // ignore: cast_nullable_to_non_nullable
                    as int,
        depositPaid:
            null == depositPaid
                ? _value.depositPaid
                : depositPaid // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        createdBy:
            null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractImpl implements _Contract {
  const _$ContractImpl({
    required this.id,
    required this.contractNumber,
    required this.roomId,
    required this.tenantId,
    required this.buildingId,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.depositPaid,
    required this.status,
    required this.createdBy,
  });

  factory _$ContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractImplFromJson(json);

  @override
  final String id;
  @override
  final String contractNumber;
  @override
  final String roomId;
  @override
  final String tenantId;
  @override
  final String buildingId;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final int monthlyRent;
  @override
  final int depositPaid;
  @override
  final String status;
  @override
  final String createdBy;

  @override
  String toString() {
    return 'Contract(id: $id, contractNumber: $contractNumber, roomId: $roomId, tenantId: $tenantId, buildingId: $buildingId, startDate: $startDate, endDate: $endDate, monthlyRent: $monthlyRent, depositPaid: $depositPaid, status: $status, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contractNumber, contractNumber) ||
                other.contractNumber == contractNumber) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.buildingId, buildingId) ||
                other.buildingId == buildingId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.monthlyRent, monthlyRent) ||
                other.monthlyRent == monthlyRent) &&
            (identical(other.depositPaid, depositPaid) ||
                other.depositPaid == depositPaid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    contractNumber,
    roomId,
    tenantId,
    buildingId,
    startDate,
    endDate,
    monthlyRent,
    depositPaid,
    status,
    createdBy,
  );

  /// Create a copy of Contract
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractImplCopyWith<_$ContractImpl> get copyWith =>
      __$$ContractImplCopyWithImpl<_$ContractImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractImplToJson(this);
  }
}

abstract class _Contract implements Contract {
  const factory _Contract({
    required final String id,
    required final String contractNumber,
    required final String roomId,
    required final String tenantId,
    required final String buildingId,
    required final String startDate,
    required final String endDate,
    required final int monthlyRent,
    required final int depositPaid,
    required final String status,
    required final String createdBy,
  }) = _$ContractImpl;

  factory _Contract.fromJson(Map<String, dynamic> json) =
      _$ContractImpl.fromJson;

  @override
  String get id;
  @override
  String get contractNumber;
  @override
  String get roomId;
  @override
  String get tenantId;
  @override
  String get buildingId;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  int get monthlyRent;
  @override
  int get depositPaid;
  @override
  String get status;
  @override
  String get createdBy;

  /// Create a copy of Contract
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractImplCopyWith<_$ContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
