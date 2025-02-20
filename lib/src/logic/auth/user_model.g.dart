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
      createdAt: UserModel._fromJson(json['createdAt']),
      updatedAt: UserModel._fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'value': instance.value,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'otherNames': instance.otherNames,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'createdAt': UserModel._toJson(instance.createdAt),
      'updatedAt': UserModel._toJson(instance.updatedAt),
    };

const _$UserTypeEnumMap = {
  UserType.guest: 'guest',
  UserType.staff: 'staff',
  UserType.admin: 'admin',
};
