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

  addUser(UserModel user, String uid) async {
    await userStore.add(user.toJson());
  }

  Future<UserModel?> getUser(String uid) async {
    return userStore.where('value', isEqualTo:  uid).limit(1).get().then((val) {
          return val.docs.firstOrNull?.data() != null
              ? UserModel.fromJson(val.docs.first.data())
              : null;
        });
  }
}
