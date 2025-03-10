// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      msg: json['msg'] as String,
      type: $enumDecode(_$ServiceTypeEnumMap, json['type']),
      createdAt: ServiceModel._fromJson(json['createdAt']),
      updatedAt: ServiceModel._fromJson(json['updatedAt']),
      fulfilled: json['fulfilled'] as bool,
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      room: json['room'] == null
          ? null
          : RoomModel.fromJson(json['room'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'type': _$ServiceTypeEnumMap[instance.type]!,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'fulfilled': instance.fulfilled,
      'createdAt': ServiceModel._toJson(instance.createdAt),
      'updatedAt': ServiceModel._toJson(instance.updatedAt),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.cleaning: 'cleaning',
  ServiceType.laundry: 'laundry',
  ServiceType.request: 'request',
};
