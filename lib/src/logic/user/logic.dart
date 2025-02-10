import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/auth/user_model.dart';

class UserLogic extends GetxController {
  static UserLogic get to => Get.find<UserLogic>();

  static UserLogic get put => Get.put(UserLogic());

  late final CollectionReference<Map<String, dynamic>> userStore;

  final _key = 'Users';

  @override
  void onInit() {
    super.onInit();
    userStore = FirebaseFirestore.instance.collection(_key);
  }

  addUser(UserModel user) async {
    await userStore.doc(user.email).set(user.toJson());
  }
}
