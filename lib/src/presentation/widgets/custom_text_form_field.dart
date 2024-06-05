import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.borderColor = Colors.black,
    this.isPasswordField = false,
    this.suffixIcon,
    this.readOnly = false,
    this.iconColor = Colors.black,
    this.controller,
    this.onTap,
    this.onSuffixIconTap,
    this.isNumericKeyboardType = false,
    this.enableInteractiveSelection = true,
    this.height,
    this.width,
    this.isRoundedTextField = false,
  });

  final String hintText;
  final Color iconColor;
  final Color borderColor;
  final bool isPasswordField;
  final bool readOnly;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool isNumericKeyboardType;
  final bool enableInteractiveSelection;
  final double? width;
  final double? height;
  final bool isRoundedTextField;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        keyboardType: isNumericKeyboardType ? TextInputType.number : null,
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        obscureText: isPasswordField,
        enableInteractiveSelection: enableInteractiveSelection,
        style: TextStyle(color: ColorManager.blackColor),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: ColorManager.greyColor,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onSuffixIconTap, icon: suffixIcon!)
              : null,
          suffixIconColor: iconColor,
          enabledBorder: isRoundedTextField
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
          focusedBorder: isRoundedTextField
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
        ),
      ),
    );
  }
}
