import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import 'email_screen.dart';
import 'widgets/app_button.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_section_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = "/SignUpScreen";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 110,
          leading: leadingAppBarWidget(context),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 19, bottom: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerSectionWidget(
                context: context,
                title: "Create your free account",
              ),
              bodyWidget(context),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bodyWidget(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .27,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appButton(
          isGoogleButton: true,
          context: context,
          label: "Continue with Google",
          onPress: () {},
          disabled: false,
          buttonColor: const Color(0xFFF4F4F4),
          buttonTextColor: Colors.black,
        ),
        const Text(
          "Or",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: ColorConstant.subtitleTextColor,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            appButton(
              context: context,
              label: "Continue with email",
              onPress: () => Get.to(() => const UserEmailScreen()),
              disabled: false,
            ),
            const SizedBox(
              height: 16,
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: ColorConstant.subtitleTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text: "By signing up, you agree ",
                  ),
                  TextSpan(
                    text: "Terms Of Service",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: ColorConstant.subtitleTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                text: "And ",
                children: [
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget leadingAppBarWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 9,
      right: 9,
      left: 16,
      bottom: 9,
    ),
    child: InkWell(
      onTap: () => Get.back(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            "Sign in",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget footer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/svg_icon/globe.svg"),
          const SizedBox(
            width: 4,
          ),
          DropdownButton(
            value: "en",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorConstant.subtitleTextColor,
            ),
            padding: const EdgeInsets.all(4),
            isDense: true,
            underline: const SizedBox.shrink(),
            menuMaxHeight: 80,
            itemHeight: 50,
            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "ar",
                child: Text("Arabic"),
              ),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      footerSectionWidget(),
    ],
  );
}
