import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:extension_helpers/extension_helpers.dart';
import 'package:nosk/src/logic/storage/logic.dart';

class AuthLogic extends GetxController {
  static AuthLogic get to => Get.find<AuthLogic>();

  static AuthLogic get put => Get.put(AuthLogic());

  final String _key = 'auth';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Rx<String?> authToken = Rx<String?>(null);

  bool get hasLoggedIn => (authToken.value).isNothing;

  @override
  void onInit() {
    super.onInit();
    String? token = storage.read<String?>(_key);
    if (!(token).isNothing) {
      authToken.value = token;
    }
  }
}
