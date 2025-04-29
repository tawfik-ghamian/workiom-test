import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants.dart';

Widget footerSectionWidget() {
  return SizedBox(
    height: 31,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Stay organized with",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: ColorConstant.subtitleTextColor,
            letterSpacing: -0.24,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        SvgPicture.asset("assets/app_logos/splash_logo.svg"),
      ],
    ),
  );
}
