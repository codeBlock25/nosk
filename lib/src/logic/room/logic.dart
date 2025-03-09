import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/error.dart';
import 'package:nosk/src/logic/room/room_model.dart';

class RoomLogic extends GetxController {
  static RoomLogic get to => Get.find<RoomLogic>();

  static RoomLogic get put => Get.put(RoomLogic());

  static String get key => 'Rooms';

  late final CollectionReference<Map<String, dynamic>> store;

  @override
  void onInit() {
    super.onInit();
    store = FirebaseFirestore.instance.collection(RoomLogic.key);
  }

  Future<bool> exist({required String name}) async {
    try {
      final snapshot = await store.doc(name.toLowerCase().trim()).get();
      return snapshot.exists;
    } catch (error) {
      throw AppError(message: 'Error verifying room data.', error: error);
    }
  }

  addRoom({
    required RoomModel newRoom,
  }) async {
    try {
      if (await exist(name: newRoom.name)) {
        throw AppError(message: 'Room already exist');
      }
      await store.doc(newRoom.name.toLowerCase().trim()).set(newRoom.toJson());
      return '${newRoom.name.capitalize ?? ''} Room added successfully.';
    } on AppError catch (error) {
      debugPrint(error.toString());
      throw Exception(error.message);
    } on FirebaseException catch (error) {
      throw Exception(
        error.message ??
            'Ops!, An error occurred, please check you internet connection.',
      );
    } catch (error) {
      throw Exception(
        'Ops!, An unexpected error occurred, please retry action or contact support for further assistance.',
      );
    }
  }

  Stream<QuerySnapshot<RoomModel>> getRooms() {
    return store
        .withConverter(
          fromFirestore: RoomModel.fromFirestore,
          toFirestore: (RoomModel room, _) => room.toJson(),
        )
        .snapshots();
  }
}
