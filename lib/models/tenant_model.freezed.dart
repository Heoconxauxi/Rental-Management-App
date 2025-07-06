// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Tenant _$TenantFromJson(Map<String, dynamic> json) {
  return _Tenant.fromJson(json);
}

/// @nodoc
mixin _$Tenant {
  String get id => throw _privateConstructorUsedError;
  String? get accountId => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get occupation => throw _privateConstructorUsedError;
  String get workplace => throw _privateConstructorUsedError;
  int get monthlyIncome => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get currentRoomId => throw _privateConstructorUsedError;

  /// Serializes this Tenant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TenantCopyWith<Tenant> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantCopyWith<$Res> {
  factory $TenantCopyWith(Tenant value, $Res Function(Tenant) then) =
      _$TenantCopyWithImpl<$Res, Tenant>;
  @useResult
  $Res call({
    String id,
    String? accountId,
    String fullName,
    String phone,
    String email,
    String gender,
    String occupation,
    String workplace,
    int monthlyIncome,
    String status,
    String? currentRoomId,
  });
}

/// @nodoc
class _$TenantCopyWithImpl<$Res, $Val extends Tenant>
    implements $TenantCopyWith<$Res> {
  _$TenantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = freezed,
    Object? fullName = null,
    Object? phone = null,
    Object? email = null,
    Object? gender = null,
    Object? occupation = null,
    Object? workplace = null,
    Object? monthlyIncome = null,
    Object? status = null,
    Object? currentRoomId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            accountId:
                freezed == accountId
                    ? _value.accountId
                    : accountId // ignore: cast_nullable_to_non_nullable
                        as String?,
            fullName:
                null == fullName
                    ? _value.fullName
                    : fullName // ignore: cast_nullable_to_non_nullable
                        as String,
            phone:
                null == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            gender:
                null == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String,
            occupation:
                null == occupation
                    ? _value.occupation
                    : occupation // ignore: cast_nullable_to_non_nullable
                        as String,
            workplace:
                null == workplace
                    ? _value.workplace
                    : workplace // ignore: cast_nullable_to_non_nullable
                        as String,
            monthlyIncome:
                null == monthlyIncome
                    ? _value.monthlyIncome
                    : monthlyIncome // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            currentRoomId:
                freezed == currentRoomId
                    ? _value.currentRoomId
                    : currentRoomId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TenantImplCopyWith<$Res> implements $TenantCopyWith<$Res> {
  factory _$$TenantImplCopyWith(
    _$TenantImpl value,
    $Res Function(_$TenantImpl) then,
  ) = __$$TenantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? accountId,
    String fullName,
    String phone,
    String email,
    String gender,
    String occupation,
    String workplace,
    int monthlyIncome,
    String status,
    String? currentRoomId,
  });
}

/// @nodoc
class __$$TenantImplCopyWithImpl<$Res>
    extends _$TenantCopyWithImpl<$Res, _$TenantImpl>
    implements _$$TenantImplCopyWith<$Res> {
  __$$TenantImplCopyWithImpl(
    _$TenantImpl _value,
    $Res Function(_$TenantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = freezed,
    Object? fullName = null,
    Object? phone = null,
    Object? email = null,
    Object? gender = null,
    Object? occupation = null,
    Object? workplace = null,
    Object? monthlyIncome = null,
    Object? status = null,
    Object? currentRoomId = freezed,
  }) {
    return _then(
      _$TenantImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        accountId:
            freezed == accountId
                ? _value.accountId
                : accountId // ignore: cast_nullable_to_non_nullable
                    as String?,
        fullName:
            null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                    as String,
        phone:
            null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        gender:
            null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String,
        occupation:
            null == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                    as String,
        workplace:
            null == workplace
                ? _value.workplace
                : workplace // ignore: cast_nullable_to_non_nullable
                    as String,
        monthlyIncome:
            null == monthlyIncome
                ? _value.monthlyIncome
                : monthlyIncome // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        currentRoomId:
            freezed == currentRoomId
                ? _value.currentRoomId
                : currentRoomId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TenantImpl implements _Tenant {
  const _$TenantImpl({
    required this.id,
    this.accountId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.occupation,
    required this.workplace,
    required this.monthlyIncome,
    required this.status,
    this.currentRoomId,
  });

  factory _$TenantImpl.fromJson(Map<String, dynamic> json) =>
      _$$TenantImplFromJson(json);

  @override
  final String id;
  @override
  final String? accountId;
  @override
  final String fullName;
  @override
  final String phone;
  @override
  final String email;
  @override
  final String gender;
  @override
  final String occupation;
  @override
  final String workplace;
  @override
  final int monthlyIncome;
  @override
  final String status;
  @override
  final String? currentRoomId;

  @override
  String toString() {
    return 'Tenant(id: $id, accountId: $accountId, fullName: $fullName, phone: $phone, email: $email, gender: $gender, occupation: $occupation, workplace: $workplace, monthlyIncome: $monthlyIncome, status: $status, currentRoomId: $currentRoomId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.workplace, workplace) ||
                other.workplace == workplace) &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentRoomId, currentRoomId) ||
                other.currentRoomId == currentRoomId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accountId,
    fullName,
    phone,
    email,
    gender,
    occupation,
    workplace,
    monthlyIncome,
    status,
    currentRoomId,
  );

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      __$$TenantImplCopyWithImpl<_$TenantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TenantImplToJson(this);
  }
}

abstract class _Tenant implements Tenant {
  const factory _Tenant({
    required final String id,
    final String? accountId,
    required final String fullName,
    required final String phone,
    required final String email,
    required final String gender,
    required final String occupation,
    required final String workplace,
    required final int monthlyIncome,
    required final String status,
    final String? currentRoomId,
  }) = _$TenantImpl;

  factory _Tenant.fromJson(Map<String, dynamic> json) = _$TenantImpl.fromJson;

  @override
  String get id;
  @override
  String? get accountId;
  @override
  String get fullName;
  @override
  String get phone;
  @override
  String get email;
  @override
  String get gender;
  @override
  String get occupation;
  @override
  String get workplace;
  @override
  int get monthlyIncome;
  @override
  String get status;
  @override
  String? get currentRoomId;

  /// Create a copy of Tenant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantImplCopyWith<_$TenantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
