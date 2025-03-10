import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/room/room_model.dart';

part 'service_model.g.dart';

@JsonEnum()
enum ServiceType {
  cleaning(value: 'cleaning'),
  laundry(value: 'laundry'),
  request(value: 'request');

  final String value;

  const ServiceType({required this.value});
}

@JsonSerializable()
class ServiceModel {
  final String msg;
  final ServiceType type;
  final String userId;
  final String roomId;
  final bool fulfilled;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final UserModel? user;

  @JsonKey(includeFromJson: true, includeToJson: false)
  final RoomModel? room;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  DateTime createdAt;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  DateTime updatedAt;

  static String _toJson(DateTime? value) =>
      value?.toIso8601String() ?? DateTime.now().toIso8601String();

  static DateTime _fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.tryParse(json) ?? DateTime.now();
    }
    return DateTime.now();
  }

  ServiceModel({
    required this.msg,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.fulfilled,
    required this.userId,
    required this.roomId,
    this.room,
    this.user,
  });

  /// factory.
  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  /// Connect the generated [_$ServiceModelToFrom] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  factory ServiceModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ServiceModel.fromJson(data!);
  }
}
