import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreenBinding implements Bindings {
  SplashScreenBinding();

  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
