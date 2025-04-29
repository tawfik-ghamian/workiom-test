import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  AuthBinding();

  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
