import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserType {
  guest(value: 'guest'),
  staff(value: 'staff'),
  admin(value: 'admin');

  final String value;

  const UserType({
    required this.value,
  });
}

@JsonSerializable()
class UserModel {
  String? value;
  String? username;
  String? firstName;
  String? lastName;
  String? otherNames;
  String? email;
  UserType? type;

  @TimestampConverter()
  Timestamp? createdAt;

  @TimestampConverter()
  Timestamp? updatedAt;

  UserModel({
    this.value,
    this.username,
    this.firstName,
    this.lastName,
    this.otherNames,
    this.email,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToFrom] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

class TimestampConverter implements JsonConverter<Timestamp, DateTime> {
  const TimestampConverter();

  @override
  Timestamp fromJson(DateTime json) => Timestamp.fromDate(json);

  @override
  DateTime toJson(Timestamp object) => object.toDate();
}

class UserTypeConverter implements JsonConverter<UserType, String> {
  const UserTypeConverter();

  @override
  UserType fromJson(String json) =>
      UserType.values.firstWhere((e) => e.value == json);

  @override
  String toJson(UserType object) => object.value;
}
