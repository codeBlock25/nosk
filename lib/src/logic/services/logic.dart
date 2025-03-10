import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/room/logic.dart';
import 'package:nosk/src/logic/services/service_model.dart';
import 'package:nosk/src/logic/user/logic.dart';
import 'package:uuid/uuid.dart';

class ServiceLogic extends GetxController {
  static ServiceLogic get to => Get.find<ServiceLogic>();

  static ServiceLogic get put => Get.put(ServiceLogic());

  static String get key => 'Services';

  late final CollectionReference<Map<String, dynamic>> store;

  @override
  void onInit() {
    super.onInit();
    store = FirebaseFirestore.instance.collection(ServiceLogic.key);
  }

  makeRequest({
    required ServiceModel newService,
  }) async {
    try {
      await store.doc(Uuid().v4()).set(newService.toJson());
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

  Stream<List<ServiceModel>> getServices(
      {String? userId, ServiceType? type, ServiceType? excepts}) {
    Query<Map<String, dynamic>> coll = userId == null
        ? FirebaseFirestore.instance
            .collection(ServiceLogic.key)
            .orderBy('createdAt', descending: true)
        : FirebaseFirestore.instance
            .collection(ServiceLogic.key)
            .orderBy('createdAt', descending: true)
            .where('userId', isEqualTo: userId);
    if (type != null) {
      coll = coll.where('type', isEqualTo: type.value);
    }
    if (excepts != null) {
      coll = coll.where('type', isNotEqualTo: excepts.value);
    }
    return coll.snapshots().asyncMap(
      (salesSnapshot) async {
        List<Map<String, dynamic>> salesWithUsers = [];

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
          salesWithUsers.add({
            ...saleData,
            'user': userData ?? {},
            'room': roomData ?? {},
          });
        }

        return salesWithUsers
            .map((json) => ServiceModel.fromJson(json))
            .toList();
      },
    );
  }
}
