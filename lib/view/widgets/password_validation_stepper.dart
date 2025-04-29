import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';

Widget passValidStepper(BuildContext context) {
  final AuthController controller = Get.find<AuthController>();

  return Column(
    children: [
      Stack(
        children: [
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Obx(
            () => Container(
              height: 10,
              width: MediaQuery.of(context).size.width /
                  (controller.isAllValid.value ? 1 : 2),
              decoration: BoxDecoration(
                color: controller.isAllValid.value
                    ? const Color(0xFF5BD77E)
                    : const Color(0xFFF5C044),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      Obx(
        () {
          if (controller.passValSetting.value.requiredLength == 0 &&
              !controller.passValSetting.value.requiredUppercase &&
              !controller.passValSetting.value.requiredDigit &&
              !controller.passValSetting.value.requiredLowercase &&
              !controller.passValSetting.value.requiredNonAlphanumeric) {
            return const SizedBox.shrink();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                validatePassWidget(
                    context: context,
                    isValid: controller.isAllValid.value,
                    isTitle: true,
                    title: "Not enough strong"),
                controller.passValSetting.value.requiredLength == 0
                    ? const SizedBox.shrink()
                    : validatePassWidget(
                        context: context,
                        isValid: controller.isCharacterNumberValid.value,
                        isTitle: false,
                        title:
                            "Passwords must have at least ${controller.passValSetting.value.requiredLength} characters.",
                      ),
                !controller.passValSetting.value.requiredUppercase
                    ? const SizedBox.shrink()
                    : validatePassWidget(
                        context: context,
                        isValid: controller.isUppercaseValid.value,
                        isTitle: false,
                        title:
                            "Passwords must have at least one uppercase ('A'-'Z').",
                      ),
                !controller.passValSetting.value.requiredDigit
                    ? const SizedBox.shrink()
                    : validatePassWidget(
                        context: context,
                        isValid: controller.isDigitValid.value,
                        isTitle: false,
                        title:
                            "Passwords must have at least one number (0-9)."),
                !controller.passValSetting.value.requiredLowercase
                    ? const SizedBox.shrink()
                    : validatePassWidget(
                        context: context,
                        isValid: controller.isLowercaseValid.value,
                        isTitle: false,
                        title:
                            "Passwords must have at least one lowercase ('a'-'z')."),
                !controller.passValSetting.value.requiredNonAlphanumeric
                    ? const SizedBox.shrink()
                    : validatePassWidget(
                        context: context,
                        isValid: controller.isSpecialCharactersValid.value,
                        isTitle: false,
                        title:
                            "Passwords must have at least one non alphanumeric (#,@,\$,%,*,&,!,~)"),
              ],
            );
          }
        },
      ),
    ],
  );
}

Widget validatePassWidget({
  required bool isValid,
  required bool isTitle,
  required String title,
  required BuildContext context,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SvgPicture.asset(
        isTitle && !isValid
            ? "assets/svg_icon/error_icon.svg"
            : !isValid && !isTitle
                ? "assets/svg_icon/not_valid_icon.svg"
                : "assets/svg_icon/check_icon.svg",
        height: 17,
      ),
      const SizedBox(
        width: 2.5,
      ),
      Text(
        title,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontSize: isTitle ? 15 : 12,
          fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
          color: !isTitle ? ColorConstant.subtitleTextColor : null,
        ),
      ),
    ],
  );
}
