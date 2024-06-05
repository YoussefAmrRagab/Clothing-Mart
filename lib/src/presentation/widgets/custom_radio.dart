import '../../config/themes/colors.dart';

import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final String text;
  final ValueChanged<String> onChanged;
  final double width;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: value == groupValue
              ? Border.all(color: ColorManager.primaryColor)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: value == groupValue
                    ? ColorManager.primaryColor
                    : ColorManager.blackColor),
          ),
        ),
      ),
    );
  }
}
