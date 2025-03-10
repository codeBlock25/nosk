// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_stay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomStayModel _$RoomStayModelFromJson(Map<String, dynamic> json) =>
    RoomStayModel(
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      price: (json['price'] as num).toDouble(),
      checkInAt: DateTime.parse(json['checkInAt'] as String),
      checkOutAt: json['checkOutAt'] == null
          ? null
          : DateTime.parse(json['checkOutAt'] as String),
      reservedAt: json['reservedAt'] == null
          ? null
          : DateTime.parse(json['reservedAt'] as String),
      reservedFor: json['reservedFor'] == null
          ? null
          : DateTime.parse(json['reservedFor'] as String),
    );

Map<String, dynamic> _$RoomStayModelToJson(RoomStayModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'roomId': instance.roomId,
      'price': instance.price,
      'checkInAt': instance.checkInAt.toIso8601String(),
      'checkOutAt': instance.checkOutAt?.toIso8601String(),
      'reservedAt': instance.reservedAt?.toIso8601String(),
      'reservedFor': instance.reservedFor?.toIso8601String(),
    };
