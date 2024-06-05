import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';

class SizeButton extends StatelessWidget {
  const SizeButton({
    super.key,
    required this.size,
    this.selectedSize,
    required this.onTap,
  });

  final String size;
  final String? selectedSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.s10, top: Dimensions.s8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: size == selectedSize
                  ? ColorManager.primaryColor
                  : Colors.black26,
            ),
          ),
          child: CircleAvatar(
            radius: Dimensions.s15,
            backgroundColor: size == selectedSize ? Colors.black : Colors.white,
            child: Text(
              size,
              style: TextStyle(
                color: size == selectedSize ? Colors.white : Colors.black,
                fontSize: Dimensions.s14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
