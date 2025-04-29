import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/api_states.dart';

Widget appButton({
  required BuildContext context,
  required void Function() onPress,
  required String label,
  required bool disabled,
  Color? buttonColor,
  Color? buttonTextColor,
  bool isGoogleButton = false,
  String? state,
}) {
  return ElevatedButton(
    onPressed: disabled ? null : onPress,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      disabledBackgroundColor: const Color(0xFFB5B5B5),
      disabledForegroundColor: Colors.white,
      backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
      foregroundColor: buttonTextColor ?? Colors.white,
      maximumSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * .06),
      minimumSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * .06),
    ),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isGoogleButton
                    ? SvgPicture.asset("assets/svg_icon/google_icon.svg")
                    : const SizedBox.shrink(),
                SizedBox(
                  width: isGoogleButton ? 8 : 0,
                ),
                Text(label),
                SizedBox(
                  width: state == States.loading && !disabled ? 14 : 0,
                ),
                state == States.loading && !disabled
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ))
                    : const SizedBox(),
              ],
            ),
          ),
          isGoogleButton
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "assets/svg_icon/enter_icon.svg",
                    // width: 30,
                    height: 16,
                  ),
                ),
        ],
      ),
    ),
  );
}
