import 'package:flutter/material.dart';

import '../theme/utils/my_colors.dart';
import '../theme/utils/my_strings.dart';

class MyGlobalTextFormFieldWidget extends StatelessWidget {
  const MyGlobalTextFormFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.errorText,
    this.controller,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: MyText.titleStyle(),
      cursorColor: MyColors.darkPrimary,
      cursorWidth: 1.5,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        hintText: hintText,
        hintStyle: MyText.subtitleStyle(),
        constraints: const BoxConstraints(maxHeight: 50),
        labelStyle: MyText.titleStyle(),
        label: Text(
          '$labelText',
          style: MyText.defaultStyle(fontSize: 13),
        ),
        helperStyle: MyText.subtitleStyle(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      onChanged: (value) {},
    );
  }
}
