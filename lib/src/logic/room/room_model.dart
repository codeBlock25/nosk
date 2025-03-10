import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String name;
  final String description;
  final double price;
  final bool isAvailable;
  final List<String> images;
  final List<String> amenities;
  final List<String> roomNumber;

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

  RoomModel({
    required this.name,
    required this.description,
    required this.isAvailable,
    required this.amenities,
    required this.images,
    required this.price,
    required this.roomNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  /// factory.
  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  /// Connect the generated [_$RoomModelToFrom] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  factory RoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RoomModel(
      name: data?['name'],
      amenities:
          data?['amenities'] is Iterable ? List.from(data?['amenities']) : [],
      description: data?['description'],
      images: data?['images'] is Iterable ? List.from(data?['images']) : [],
      isAvailable: data?['isAvailable'],
      price: data?['price'],
      createdAt: _fromJson(data?['createdAt']),
      updatedAt: _fromJson(data?['updatedAt']),
      roomNumber: data?['roomNumber'] is Iterable ? List.from(data?['roomNumber']) : [],
    );
  }
}
