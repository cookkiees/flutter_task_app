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
    this.isCollapsed = false,
    this.isDense = false,
    this.expands = false,
    this.constraints = const BoxConstraints(maxHeight: 50),
    this.contentPadding,
    this.helperText,
  });
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? constraints;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? helperText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isCollapsed;
  final bool isDense;
  final bool expands;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      controller: controller,
      style: MyText.titleStyle(),
      cursorColor: MyColors.darkPrimary,
      cursorWidth: 1.5,
      obscureText: obscureText,
      maxLines: expands == false ? 1 : null,
      minLines: null,
      decoration: InputDecoration(
        isDense: isDense,
        isCollapsed: isCollapsed,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        hintText: hintText,
        helperText: helperText,
        hintStyle: MyText.subtitleStyle(),
        constraints: constraints,
        labelStyle: MyText.titleStyle(color: MyColors.darkPrimary),
        contentPadding: contentPadding,
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
