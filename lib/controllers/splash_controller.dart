import 'package:get/get.dart';

import '../repositories/auth_repository.dart';
import '../utils/api_error.dart';
import '../utils/api_states.dart';
import '../view/home_screen.dart';
import '../view/sign_in_screen.dart';
import '../view/widgets/snack_bar_widget.dart';

class SplashScreenController extends GetxController {
  final authRepo = AuthRepository();

  final Rx<String> state = "".obs;

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  void checkAuth() async {
    try {
      state.value = States.loading;
      final res = await authRepo.checkAuth();
      if (res.user == "") {
        state.value = States.data;
        Get.offNamed(SignInScreen.routeName);
      } else {
        state.value = States.data;
        Get.offNamed(HomeScreen.routeName);
      }
    } catch (e) {
      state.value = States.error;
      if (e is ApiError) {
        AppSnackBar.showSnackBar(message: e.message);
      } else {
        AppSnackBar.showSnackBar(message: e.toString());
      }
    }
  }

  void onTapRefresh() {
    checkAuth();
  }
}
