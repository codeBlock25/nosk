import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/room_stay/room_stay_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:uuid/uuid.dart';

class RoomStayLogic extends GetxController {
  static RoomStayLogic get to => Get.find<RoomStayLogic>();

  static RoomStayLogic get put => Get.put(RoomStayLogic());

  static String key = 'RoomStays';

  late final CollectionReference<Map<String, dynamic>> store;

  @override
  void onInit() {
    super.onInit();
    store = FirebaseFirestore.instance.collection(RoomStayLogic.key);
  }

  checkInGuest({
    required RoomStayModel newRoomStay,
  }) {
    try {
      store.doc(Uuid().v4()).set(newRoomStay.toJson());
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

  checkInGuestRegular({
    required RoomStayModel newRoomStay,
  }) {
    try {
      store.doc(Uuid().v4()).set(newRoomStay.toJson());
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


  Stream<List<RoomStayModel>> getCheckIns() {
    try {
      return store
          .orderBy('createdAt', descending: true)
          .where('checkOutAt', isNull: true)
          .snapshots()
          .asyncMap((salesSnapshot) async {
        List<Map<String, dynamic>> checkOut = [];

        for (var sale in salesSnapshot.docs) {
          Map<String, dynamic> saleData = sale.data();
          String userId = saleData['userId'];
          String roomId = saleData['roomId'];

          // Fetch user data
          final userSnapshot = await FirebaseFirestore.instance
              .collection(UserLogic.key)
              .doc(userId)
              .get();
          Map<String, dynamic>? userData = userSnapshot.data();

          // Fetch user data
          final roomSnapshot = await FirebaseFirestore.instance
              .collection(RoomLogic.key)
              .doc(roomId)
              .get();
          Map<String, dynamic>? roomData = roomSnapshot.data();

          // Merge sale and user data
          checkOut.add({
            ...saleData,
            'user': userData ?? {},
            'room': roomData ?? {},
          });
        }

        return checkOut.map((json) => RoomStayModel.fromJson(json)).toList();
      });
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
  Stream<List<RoomStayModel>> getCheckOut() {
    try {
      return store
          .orderBy('createdAt', descending: true)
          .where('checkOutAt', isNull: false)
          .snapshots()
          .asyncMap((salesSnapshot) async {
        List<Map<String, dynamic>> checkOut = [];

        for (var sale in salesSnapshot.docs) {
          Map<String, dynamic> saleData = sale.data();
          String userId = saleData['userId'];
          String roomId = saleData['roomId'];

          // Fetch user data
          final userSnapshot = await FirebaseFirestore.instance
              .collection(UserLogic.key)
              .doc(userId)
              .get();
          Map<String, dynamic>? userData = userSnapshot.data();

          // Fetch user data
          final roomSnapshot = await FirebaseFirestore.instance
              .collection(RoomLogic.key)
              .doc(roomId)
              .get();
          Map<String, dynamic>? roomData = roomSnapshot.data();

          // Merge sale and user data
          checkOut.add({
            ...saleData,
            'user': userData ?? {},
            'room': roomData ?? {},
          });
        }

        return checkOut.map((json) => RoomStayModel.fromJson(json)).toList();
      });
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
}
