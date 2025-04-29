import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';

Widget appTextField({
  required BuildContext context,
  required Widget icon,
  required TextEditingController controller,
  required TextInputType inputType,
  required String hintText,
  String? Function(String?)? validator,
  bool? isObscureText,
  String? suffix,
  Widget? suffixIcon,
  List<TextInputFormatter>? inputFormatters,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator ??
                (value) {
                  return null;
                },
            keyboardType: inputType,
            obscuringCharacter: "*",
            obscureText: isObscureText ?? false,
            inputFormatters: inputFormatters ?? [],
            decoration: InputDecoration(
              suffixText: suffixIcon == null ? suffix : "",
              suffixIcon: suffix == null ? suffixIcon : null,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorConstant.subtitleTextColor,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD6D6D6),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
