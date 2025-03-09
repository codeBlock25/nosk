// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      name: json['name'] as String,
      description: json['description'] as String,
      isAvailable: json['isAvailable'] as bool,
      amenities:
          (json['amenities'] as List<dynamic>).map((e) => e as String).toList(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      price: (json['price'] as num).toDouble(),
      roomCount: (json['roomCount'] as num).toInt(),
      roomNumber: (json['roomNumber'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: RoomModel._fromJson(json['createdAt']),
      updatedAt: RoomModel._fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'isAvailable': instance.isAvailable,
      'roomCount': instance.roomCount,
      'images': instance.images,
      'amenities': instance.amenities,
      'roomNumber': instance.roomNumber,
      'createdAt': RoomModel._toJson(instance.createdAt),
      'updatedAt': RoomModel._toJson(instance.updatedAt),
    };
