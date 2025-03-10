import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nosk/src/logic/auth/user_model.dart';
import 'package:nosk/src/logic/room/room_model.dart';

part 'room_stay_model.g.dart';

@JsonSerializable()
class RoomStayModel {
  final String userId;
  final String roomId;
  final double price;

  final RoomModel? room;
  final UserModel? user;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final DateTime checkInAt;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final DateTime? checkOutAt;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final DateTime? reservedAt;

  @JsonKey(
    toJson: _toJson,
    fromJson: _fromJson,
  )
  final DateTime? reservedFor;

  const RoomStayModel({
    required this.userId,
    required this.roomId,
    required this.price,
    required this.checkInAt,
    required this.checkOutAt,
    required this.reservedAt,
    required this.reservedFor,
    this.room,
    this.user,
  });

  factory RoomStayModel.fromJson(Map<String, dynamic> json) =>
      _$RoomStayModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomStayModelToJson(this);

  static String? _toJson(DateTime? value) => value?.toIso8601String();

  static DateTime? _fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.tryParse(json) ?? DateTime.now();
    }
    return null;
  }

  @override
  String toString() {
    return 'RoomStayModel(userId: $userId, roomId: $roomId, price: $price, checkInAt: $checkInAt, checkOutAt: $checkOutAt, reservedAt: $reservedAt, reservedFor: $reservedFor)';
  }

  factory RoomStayModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RoomStayModel.fromJson(data!);
  }
}
