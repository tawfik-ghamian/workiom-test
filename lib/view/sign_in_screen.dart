import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'sign_up_screen.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_section_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = "/SignInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController controller = Get.find<AuthController>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign In",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 19,
              bottom: 26,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerSectionWidget(
                    context: context, title: "Enter a strong password"),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formKey,
                  onChanged: controller.autoFormValidate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your company or team name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      appTextField(
                        context: context,
                        icon: const Icon(
                          Icons.groups,
                          size: 17,
                        ),
                        controller: controller.companyNameController,
                        validator: controller.companyNameValidation,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[A-Za-z]*[A-Za-z][A-Za-z0-9-]*$'),
                          ),
                        ],
                        inputType: TextInputType.name,
                        hintText: "Workspace name*",
                        suffix: ".Workiom.com",
                      ),
                      const SizedBox(
                        height: 24,
                      ),
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
                        hintText: "Enter your email",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          hintText: "Enter your password",
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
                        height: 28,
                      ),
                      Obx(
                        () => appButton(
                          context: context,
                          label: "Sign in",
                          onPress: () => controller.signIn(),
                          disabled: controller.isButtonDisable.value,
                          state: controller.state.value,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => Get.toNamed(SignUpScreen.routeName),
                          child: const Text("Create account"),
                        ),
                      )
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
