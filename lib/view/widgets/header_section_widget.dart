import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants.dart';

Widget headerSectionWidget(
    {required BuildContext context, required String title}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        Row(
          children: [
            const Text(
              "Let's start an amazing journey!",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: ColorConstant.subtitleTextColor,
                letterSpacing: -0.41,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset("assets/svg_icon/shake_hand.svg"),
          ],
        ),
      ],
    ),
  );
}
