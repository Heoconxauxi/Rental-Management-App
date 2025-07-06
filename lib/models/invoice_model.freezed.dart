// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Invoice _$InvoiceFromJson(Map<String, dynamic> json) {
  return _Invoice.fromJson(json);
}

/// @nodoc
mixin _$Invoice {
  String get id => throw _privateConstructorUsedError;
  String get contractId => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get buildingId => throw _privateConstructorUsedError;
  int get invoiceMonth => throw _privateConstructorUsedError;
  int get invoiceYear => throw _privateConstructorUsedError;
  Fees get fees => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get paymentDate => throw _privateConstructorUsedError;

  /// Serializes this Invoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceCopyWith<Invoice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceCopyWith<$Res> {
  factory $InvoiceCopyWith(Invoice value, $Res Function(Invoice) then) =
      _$InvoiceCopyWithImpl<$Res, Invoice>;
  @useResult
  $Res call({
    String id,
    String contractId,
    String roomId,
    String tenantId,
    String buildingId,
    int invoiceMonth,
    int invoiceYear,
    Fees fees,
    int totalAmount,
    String status,
    String? paymentDate,
  });

  $FeesCopyWith<$Res> get fees;
}

/// @nodoc
class _$InvoiceCopyWithImpl<$Res, $Val extends Invoice>
    implements $InvoiceCopyWith<$Res> {
  _$InvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractId = null,
    Object? roomId = null,
    Object? tenantId = null,
    Object? buildingId = null,
    Object? invoiceMonth = null,
    Object? invoiceYear = null,
    Object? fees = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? paymentDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            contractId:
                null == contractId
                    ? _value.contractId
                    : contractId // ignore: cast_nullable_to_non_nullable
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
            invoiceMonth:
                null == invoiceMonth
                    ? _value.invoiceMonth
                    : invoiceMonth // ignore: cast_nullable_to_non_nullable
                        as int,
            invoiceYear:
                null == invoiceYear
                    ? _value.invoiceYear
                    : invoiceYear // ignore: cast_nullable_to_non_nullable
                        as int,
            fees:
                null == fees
                    ? _value.fees
                    : fees // ignore: cast_nullable_to_non_nullable
                        as Fees,
            totalAmount:
                null == totalAmount
                    ? _value.totalAmount
                    : totalAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String,
            paymentDate:
                freezed == paymentDate
                    ? _value.paymentDate
                    : paymentDate // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeesCopyWith<$Res> get fees {
    return $FeesCopyWith<$Res>(_value.fees, (value) {
      return _then(_value.copyWith(fees: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvoiceImplCopyWith<$Res> implements $InvoiceCopyWith<$Res> {
  factory _$$InvoiceImplCopyWith(
    _$InvoiceImpl value,
    $Res Function(_$InvoiceImpl) then,
  ) = __$$InvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String contractId,
    String roomId,
    String tenantId,
    String buildingId,
    int invoiceMonth,
    int invoiceYear,
    Fees fees,
    int totalAmount,
    String status,
    String? paymentDate,
  });

  @override
  $FeesCopyWith<$Res> get fees;
}

/// @nodoc
class __$$InvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceCopyWithImpl<$Res, _$InvoiceImpl>
    implements _$$InvoiceImplCopyWith<$Res> {
  __$$InvoiceImplCopyWithImpl(
    _$InvoiceImpl _value,
    $Res Function(_$InvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? contractId = null,
    Object? roomId = null,
    Object? tenantId = null,
    Object? buildingId = null,
    Object? invoiceMonth = null,
    Object? invoiceYear = null,
    Object? fees = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? paymentDate = freezed,
  }) {
    return _then(
      _$InvoiceImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        contractId:
            null == contractId
                ? _value.contractId
                : contractId // ignore: cast_nullable_to_non_nullable
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
        invoiceMonth:
            null == invoiceMonth
                ? _value.invoiceMonth
                : invoiceMonth // ignore: cast_nullable_to_non_nullable
                    as int,
        invoiceYear:
            null == invoiceYear
                ? _value.invoiceYear
                : invoiceYear // ignore: cast_nullable_to_non_nullable
                    as int,
        fees:
            null == fees
                ? _value.fees
                : fees // ignore: cast_nullable_to_non_nullable
                    as Fees,
        totalAmount:
            null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String,
        paymentDate:
            freezed == paymentDate
                ? _value.paymentDate
                : paymentDate // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$InvoiceImpl implements _Invoice {
  const _$InvoiceImpl({
    required this.id,
    required this.contractId,
    required this.roomId,
    required this.tenantId,
    required this.buildingId,
    required this.invoiceMonth,
    required this.invoiceYear,
    required this.fees,
    required this.totalAmount,
    required this.status,
    this.paymentDate,
  });

  factory _$InvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceImplFromJson(json);

  @override
  final String id;
  @override
  final String contractId;
  @override
  final String roomId;
  @override
  final String tenantId;
  @override
  final String buildingId;
  @override
  final int invoiceMonth;
  @override
  final int invoiceYear;
  @override
  final Fees fees;
  @override
  final int totalAmount;
  @override
  final String status;
  @override
  final String? paymentDate;

  @override
  String toString() {
    return 'Invoice(id: $id, contractId: $contractId, roomId: $roomId, tenantId: $tenantId, buildingId: $buildingId, invoiceMonth: $invoiceMonth, invoiceYear: $invoiceYear, fees: $fees, totalAmount: $totalAmount, status: $status, paymentDate: $paymentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contractId, contractId) ||
                other.contractId == contractId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.buildingId, buildingId) ||
                other.buildingId == buildingId) &&
            (identical(other.invoiceMonth, invoiceMonth) ||
                other.invoiceMonth == invoiceMonth) &&
            (identical(other.invoiceYear, invoiceYear) ||
                other.invoiceYear == invoiceYear) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    contractId,
    roomId,
    tenantId,
    buildingId,
    invoiceMonth,
    invoiceYear,
    fees,
    totalAmount,
    status,
    paymentDate,
  );

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      __$$InvoiceImplCopyWithImpl<_$InvoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceImplToJson(this);
  }
}

abstract class _Invoice implements Invoice {
  const factory _Invoice({
    required final String id,
    required final String contractId,
    required final String roomId,
    required final String tenantId,
    required final String buildingId,
    required final int invoiceMonth,
    required final int invoiceYear,
    required final Fees fees,
    required final int totalAmount,
    required final String status,
    final String? paymentDate,
  }) = _$InvoiceImpl;

  factory _Invoice.fromJson(Map<String, dynamic> json) = _$InvoiceImpl.fromJson;

  @override
  String get id;
  @override
  String get contractId;
  @override
  String get roomId;
  @override
  String get tenantId;
  @override
  String get buildingId;
  @override
  int get invoiceMonth;
  @override
  int get invoiceYear;
  @override
  Fees get fees;
  @override
  int get totalAmount;
  @override
  String get status;
  @override
  String? get paymentDate;

  /// Create a copy of Invoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceImplCopyWith<_$InvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Fees _$FeesFromJson(Map<String, dynamic> json) {
  return _Fees.fromJson(json);
}

/// @nodoc
mixin _$Fees {
  int get roomRent => throw _privateConstructorUsedError;
  int get electricity => throw _privateConstructorUsedError;
  int get water => throw _privateConstructorUsedError;
  int get serviceFee => throw _privateConstructorUsedError;
  int get parkingFee => throw _privateConstructorUsedError;

  /// Serializes this Fees to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fees
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeesCopyWith<Fees> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeesCopyWith<$Res> {
  factory $FeesCopyWith(Fees value, $Res Function(Fees) then) =
      _$FeesCopyWithImpl<$Res, Fees>;
  @useResult
  $Res call({
    int roomRent,
    int electricity,
    int water,
    int serviceFee,
    int parkingFee,
  });
}

/// @nodoc
class _$FeesCopyWithImpl<$Res, $Val extends Fees>
    implements $FeesCopyWith<$Res> {
  _$FeesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fees
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomRent = null,
    Object? electricity = null,
    Object? water = null,
    Object? serviceFee = null,
    Object? parkingFee = null,
  }) {
    return _then(
      _value.copyWith(
            roomRent:
                null == roomRent
                    ? _value.roomRent
                    : roomRent // ignore: cast_nullable_to_non_nullable
                        as int,
            electricity:
                null == electricity
                    ? _value.electricity
                    : electricity // ignore: cast_nullable_to_non_nullable
                        as int,
            water:
                null == water
                    ? _value.water
                    : water // ignore: cast_nullable_to_non_nullable
                        as int,
            serviceFee:
                null == serviceFee
                    ? _value.serviceFee
                    : serviceFee // ignore: cast_nullable_to_non_nullable
                        as int,
            parkingFee:
                null == parkingFee
                    ? _value.parkingFee
                    : parkingFee // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeesImplCopyWith<$Res> implements $FeesCopyWith<$Res> {
  factory _$$FeesImplCopyWith(
    _$FeesImpl value,
    $Res Function(_$FeesImpl) then,
  ) = __$$FeesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int roomRent,
    int electricity,
    int water,
    int serviceFee,
    int parkingFee,
  });
}

/// @nodoc
class __$$FeesImplCopyWithImpl<$Res>
    extends _$FeesCopyWithImpl<$Res, _$FeesImpl>
    implements _$$FeesImplCopyWith<$Res> {
  __$$FeesImplCopyWithImpl(_$FeesImpl _value, $Res Function(_$FeesImpl) _then)
    : super(_value, _then);

  /// Create a copy of Fees
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomRent = null,
    Object? electricity = null,
    Object? water = null,
    Object? serviceFee = null,
    Object? parkingFee = null,
  }) {
    return _then(
      _$FeesImpl(
        roomRent:
            null == roomRent
                ? _value.roomRent
                : roomRent // ignore: cast_nullable_to_non_nullable
                    as int,
        electricity:
            null == electricity
                ? _value.electricity
                : electricity // ignore: cast_nullable_to_non_nullable
                    as int,
        water:
            null == water
                ? _value.water
                : water // ignore: cast_nullable_to_non_nullable
                    as int,
        serviceFee:
            null == serviceFee
                ? _value.serviceFee
                : serviceFee // ignore: cast_nullable_to_non_nullable
                    as int,
        parkingFee:
            null == parkingFee
                ? _value.parkingFee
                : parkingFee // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeesImpl implements _Fees {
  const _$FeesImpl({
    required this.roomRent,
    required this.electricity,
    required this.water,
    required this.serviceFee,
    required this.parkingFee,
  });

  factory _$FeesImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeesImplFromJson(json);

  @override
  final int roomRent;
  @override
  final int electricity;
  @override
  final int water;
  @override
  final int serviceFee;
  @override
  final int parkingFee;

  @override
  String toString() {
    return 'Fees(roomRent: $roomRent, electricity: $electricity, water: $water, serviceFee: $serviceFee, parkingFee: $parkingFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeesImpl &&
            (identical(other.roomRent, roomRent) ||
                other.roomRent == roomRent) &&
            (identical(other.electricity, electricity) ||
                other.electricity == electricity) &&
            (identical(other.water, water) || other.water == water) &&
            (identical(other.serviceFee, serviceFee) ||
                other.serviceFee == serviceFee) &&
            (identical(other.parkingFee, parkingFee) ||
                other.parkingFee == parkingFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    roomRent,
    electricity,
    water,
    serviceFee,
    parkingFee,
  );

  /// Create a copy of Fees
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeesImplCopyWith<_$FeesImpl> get copyWith =>
      __$$FeesImplCopyWithImpl<_$FeesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeesImplToJson(this);
  }
}

abstract class _Fees implements Fees {
  const factory _Fees({
    required final int roomRent,
    required final int electricity,
    required final int water,
    required final int serviceFee,
    required final int parkingFee,
  }) = _$FeesImpl;

  factory _Fees.fromJson(Map<String, dynamic> json) = _$FeesImpl.fromJson;

  @override
  int get roomRent;
  @override
  int get electricity;
  @override
  int get water;
  @override
  int get serviceFee;
  @override
  int get parkingFee;

  /// Create a copy of Fees
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeesImplCopyWith<_$FeesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
