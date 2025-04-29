import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'widgets/app_button.dart';
import 'widgets/app_text_field.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_section_widget.dart';

class WorkSpaceInfoScreen extends StatefulWidget {
  const WorkSpaceInfoScreen({super.key});

  static const routeName = "/WorkSpaceInfoScreen";

  @override
  State<WorkSpaceInfoScreen> createState() => _WorkSpaceInfoScreenState();
}

class _WorkSpaceInfoScreenState extends State<WorkSpaceInfoScreen> {
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
                  key: controller.workspaceFormKey,
                  onChanged: () {
                    if (controller.workspaceFormKey.currentState!.validate()) {
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
                        "Your first name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      appTextField(
                        context: context,
                        icon: SvgPicture.asset(
                          "assets/svg_icon/username_icon.svg",
                          height: 17,
                        ),
                        controller: controller.firstNameController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r' '),
                          ),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          )
                        ],
                        validator: controller.firstNameValidation,
                        inputType: TextInputType.name,
                        hintText: "Enter your first name",
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "Your last name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      appTextField(
                        context: context,
                        icon: SvgPicture.asset(
                          "assets/svg_icon/username_icon.svg",
                          height: 17,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                            RegExp(r' '),
                          ),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          )
                        ],
                        validator: controller.lastNameValidation,
                        controller: controller.lastNameController,
                        inputType: TextInputType.name,
                        hintText: "Enter your last name",
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Obx(
                        () => appButton(
                          context: context,
                          label: "Create Workspace",
                          onPress: () => controller.signUp(),
                          disabled: controller.isButtonDisable.value,
                          state: controller.state.value,
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
