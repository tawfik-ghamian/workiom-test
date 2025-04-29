import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/editions/editions_model.dart';
import '../models/password/complexity_settings_model.dart';
import '../models/sign_in/sign_in_request_model.dart';
import '../models/sign_in/sign_in_response_model.dart';
import '../models/signup/signup_request_model.dart';
import '../models/signup/signup_response_model.dart';
import '../repositories/auth_repository.dart';
import '../utils/api_error.dart';
import '../utils/api_states.dart';
import '../utils/set_local_timezone.dart';
import '../utils/shared_prefs.dart';
import '../view/home_screen.dart';
import '../view/sign_in_screen.dart';
import '../view/widgets/snack_bar_widget.dart';

class AuthController extends GetxController {
  final authRepo = AuthRepository();

  final formKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final workspaceFormKey = GlobalKey<FormState>();
  final Rx<String> state = "".obs;
  final Rx<bool> isPassVisible = true.obs;
  final Rx<bool> isButtonDisable = true.obs;
  final Rx<bool> isDigitValid = false.obs;
  final Rx<bool> isUppercaseValid = false.obs;
  final Rx<bool> isLowercaseValid = false.obs;
  final Rx<bool> isCharacterNumberValid = false.obs;
  final Rx<bool> isSpecialCharactersValid = false.obs;
  final Rx<bool> isAllValid = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final Rx<PassCompSettingsModel> passValSetting =
      PassCompSettingsModel.fromJson({}).obs;
  final Rx<EditionModel> edition = EditionModel.fromJson({}).obs;
  final Rx<SignUpResponseModel> signUpResponse =
      SignUpResponseModel.fromJson({}).obs;
  final Rx<SignInResponseModel> signInResponse =
      SignInResponseModel.fromJson({}).obs;

  @override
  void onInit() {
    getValidationSettingPassword();
    getEditions();
    super.onInit();
  }

  void autoFormValidate() {
    if (formKey.currentState!.validate()) {
      isButtonDisable.value = false;
    } else {
      isButtonDisable.value = true;
    }
  }

  void signUp() async {
    try {
      state.value = States.loading;
      final checkRes =
          await authRepo.checkTenantAvailability(companyNameController.text);
      if (checkRes == -1) {
        final res = await authRepo.signUp(
          requestModel: SignUpRequestModel(
            name: companyNameController.text,
            email: emailController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            password: passwordController.text,
            editionId: edition.value.editionId,
            tenantName: companyNameController.text,
          ),
        );
        if (res.tenantId != -1) {
          state.value = States.data;
          Get.offNamed(SignInScreen.routeName);
        }
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

  void signIn() async {
    try {
      state.value = States.loading;
      final res = await authRepo.signIn(
        requestModel: SignInRequestModel(
          email: emailController.text,
          password: passwordController.text,
          tenantName: companyNameController.text,
          timeZone: await setupTimeZone(),
        ),
      );
      if (res.accessToken != "") {
        await SharedPrefs().setAccessToken(res.accessToken);
        final response = await authRepo.checkAuth();
        if (response.user != "") {
          state.value = States.data;
          AppSnackBar.showSnackBar(
              message: "Welcome ${response.user}",
              icon: Icons.done_all_outlined);
          Get.offNamed(HomeScreen.routeName);
        }
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

  void getEditions() async {
    try {
      state.value = States.loading;
      final List<EditionModel> res = await authRepo.getEditions();
      if (res.isNotEmpty) {
        edition.value = res[0];
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

  void getValidationSettingPassword() async {
    try {
      state.value = States.loading;
      final res = await authRepo.getPassCompSettings();
      passValSetting.value = res;
    } catch (e) {
      state.value = States.error;
      if (e is ApiError) {
        AppSnackBar.showSnackBar(message: e.message);
      } else {
        AppSnackBar.showSnackBar(message: e.toString());
      }
    }
  }

  void visibleToggle() {
    isPassVisible.value = !isPassVisible.value;
  }

  void clearEmailController() {
    emailController.clear();
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? passwordValidator(String? password) {
    if (password != null && password.isNotEmpty) {
      isAllValid.value = false;

      if (passValSetting.value.requiredLength != 0 &&
          password.length < passValSetting.value.requiredLength) {
        isCharacterNumberValid.value = false;
        return 'Enter a valid email address';
      } else {
        isCharacterNumberValid.value = true;
      }
      if (passValSetting.value.requiredLowercase &&
          !RegExp(r'[a-z]').hasMatch(password)) {
        isLowercaseValid.value = false;
        return 'Enter a valid email address';
      } else {
        isLowercaseValid.value = true;
      }
      if (passValSetting.value.requiredUppercase &&
          !RegExp(r'[A-Z]').hasMatch(password)) {
        isUppercaseValid.value = false;
        return 'Enter a valid email address';
      } else {
        isUppercaseValid.value = true;
      }
      if (passValSetting.value.requiredDigit &&
          !RegExp(r'[0-9]').hasMatch(password)) {
        isDigitValid.value = false;
        return 'Enter a valid email address';
      } else {
        isDigitValid.value = true;
      }
      if (passValSetting.value.requiredNonAlphanumeric &&
          !RegExp(r'[!@#$&*~]').hasMatch(password)) {
        isSpecialCharactersValid.value = false;
        return 'Enter a valid email address';
      } else {
        isSpecialCharactersValid.value = true;
      }
    } else {
      return 'Enter a valid email address';
    }
    isAllValid.value = true;
    return null;
  }

  String? companyNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your company or team name';
    }
    return null;
  }

  String? firstNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? lastNameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  @override
  void onClose() {
    isAllValid.close();
    isSpecialCharactersValid.close();
    isLowercaseValid.close();
    isDigitValid.close();
    isUppercaseValid.close();
    isCharacterNumberValid.close();
    isButtonDisable.close();
    isPassVisible.close();
    companyNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    super.onClose();
  }
}
