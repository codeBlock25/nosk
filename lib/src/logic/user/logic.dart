import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nosk/src/logic/auth/logic.dart';
import 'package:nosk/src/logic/auth/user_model.dart';

class UserLogic extends GetxController {
  static UserLogic get to => Get.find<UserLogic>();

  static UserLogic get put => Get.put(UserLogic());

  late final CollectionReference<Map<String, dynamic>> userStore;

  static final key = 'Users';

  @override
  void onInit() {
    super.onInit();
    userStore = FirebaseFirestore.instance.collection(key);
  }

  addUser(UserModel user, String uid) async {
    await userStore.add(user.toJson());
  }

  createUser(UserModel user) async {
    final AuthLogic authLogic = AuthLogic.to;
    final acc = await authLogic.firebaseAuth.createUserWithEmailAndPassword(
      email: user.email ?? '',
      password: 'Password#25',
    );
    if (acc.user == null) {
      throw Exception('Error creating user');
    }
    await userStore.doc(acc.user!.uid).set(user.toJson());
  }

  Stream<QuerySnapshot<UserModel>> getUsers({required UserType type}) {
    return userStore
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel json, _) => json.toJson(),
        )
        .where('type', isEqualTo: type.value)
        .snapshots();
  }

  Future<UserModel?> getUser(String uid) async {
    return userStore.where('value', isEqualTo: uid).limit(1).get().then((val) {
      return val.docs.firstOrNull?.data() != null
          ? UserModel.fromJson(val.docs.first.data())
          : null;
    });
  }
}
