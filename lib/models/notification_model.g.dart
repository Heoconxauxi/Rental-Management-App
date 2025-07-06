// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationMessageImpl _$$NotificationMessageImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationMessageImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  targetType: json['targetType'] as String,
  targetId: json['targetId'] as String,
  sendDate: json['sendDate'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$$NotificationMessageImplToJson(
  _$NotificationMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'targetType': instance.targetType,
  'targetId': instance.targetId,
  'sendDate': instance.sendDate,
  'status': instance.status,
};
