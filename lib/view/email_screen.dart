import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_section_widget.dart';
import 'widgets/password_validation_stepper.dart';
import 'workspace_info_screen.dart';

class UserEmailScreen extends StatefulWidget {
  const UserEmailScreen({super.key});

  static const routeName = "/EmailScreen";

  @override
  State<UserEmailScreen> createState() => _UserEmailScreenState();
}

class _UserEmailScreenState extends State<UserEmailScreen> {
  AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 19, bottom: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerSectionWidget(
                    context: context, title: "Enter a strong password"),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.emailFormKey,
                  onChanged: () {
                    if (controller.emailFormKey.currentState!.validate()) {
                      controller.isButtonDisable.value = false;
                    } else {
                      controller.isButtonDisable.value = true;
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your work email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      appTextField(
                        context: context,
                        icon: const Icon(
                          Icons.email_outlined,
                          // size: 22,
                        ),
                        controller: controller.emailController,
                        validator: controller.validateEmail,
                        inputType: TextInputType.emailAddress,
                        hintText: "Enter your Email",
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r' ')),
                          FilteringTextInputFormatter.deny(RegExp(r'-'))
                        ],
                        suffixIcon: controller.emailController.text == ""
                            ? null
                            : IconButton(
                                onPressed: controller.clearEmailController,
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xFF747474),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "Your password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Obx(
                        () => appTextField(
                          context: context,
                          icon: const Icon(Icons.lock_outline_rounded),
                          controller: controller.passwordController,
                          validator: controller.passwordValidator,
                          inputType: TextInputType.visiblePassword,
                          hintText: "Enter your Password",
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r' ')),
                          ],
                          isObscureText: controller.isPassVisible.value,
                          suffixIcon: IconButton(
                            onPressed: controller.visibleToggle,
                            icon: Icon(
                              controller.isPassVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF747474),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      passValidStepper(context),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(
                        () => appButton(
                          context: context,
                          label: "Confirm password",
                          onPress: () =>
                              Get.to(() => const WorkSpaceInfoScreen()),
                          disabled: controller.isButtonDisable.value,
                        ),
                      ),
                    ],
                  ),
                ),
                footerSectionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
