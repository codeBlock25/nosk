// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      value: json['value'] as String?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      otherNames: json['otherNames'] as String?,
      email: json['email'] as String?,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']),
      createdAt: _$JsonConverterFromJson<DateTime, Timestamp>(
          json['createdAt'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<DateTime, Timestamp>(
          json['updatedAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'value': instance.value,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'otherNames': instance.otherNames,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'createdAt': _$JsonConverterToJson<DateTime, Timestamp>(
          instance.createdAt, const TimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<DateTime, Timestamp>(
          instance.updatedAt, const TimestampConverter().toJson),
    };

const _$UserTypeEnumMap = {
  UserType.guest: 'guest',
  UserType.staff: 'staff',
  UserType.admin: 'admin',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
