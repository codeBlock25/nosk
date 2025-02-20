// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserModelCWProxy {
  UserModel value(String? value);

  UserModel phoneNumber(String? phoneNumber);

  UserModel firstName(String? firstName);

  UserModel lastName(String? lastName);

  UserModel otherNames(String? otherNames);

  UserModel email(String? email);

  UserModel type(UserType? type);

  UserModel createdAt(DateTime? createdAt);

  UserModel updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    String? value,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? otherNames,
    String? email,
    UserType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserModel.copyWith.fieldName(...)`
class _$UserModelCWProxyImpl implements _$UserModelCWProxy {
  const _$UserModelCWProxyImpl(this._value);

  final UserModel _value;

  @override
  UserModel value(String? value) => this(value: value);

  @override
  UserModel phoneNumber(String? phoneNumber) => this(phoneNumber: phoneNumber);

  @override
  UserModel firstName(String? firstName) => this(firstName: firstName);

  @override
  UserModel lastName(String? lastName) => this(lastName: lastName);

  @override
  UserModel otherNames(String? otherNames) => this(otherNames: otherNames);

  @override
  UserModel email(String? email) => this(email: email);

  @override
  UserModel type(UserType? type) => this(type: type);

  @override
  UserModel createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  UserModel updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserModel(...).copyWith(id: 12, name: "My name")
  /// ````
  UserModel call({
    Object? value = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? otherNames = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return UserModel(
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String?,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String?,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String?,
      otherNames: otherNames == const $CopyWithPlaceholder()
          ? _value.otherNames
          // ignore: cast_nullable_to_non_nullable
          : otherNames as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as UserType?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $UserModelCopyWith on UserModel {
  /// Returns a callable class that can be used as follows: `instanceOfUserModel.copyWith(...)` or like so:`instanceOfUserModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserModelCWProxy get copyWith => _$UserModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      value: json['value'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
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
      'phoneNumber': instance.phoneNumber,
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
