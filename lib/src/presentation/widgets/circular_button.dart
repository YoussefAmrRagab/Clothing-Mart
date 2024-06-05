import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.padding,
    required this.onTap,
  });

  final IconData icon;
  final EdgeInsets padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: Dimensions.s3,
              blurStyle: BlurStyle.outer,
              spreadRadius: -1,
            )
          ],
        ),
        child: Icon(
          icon,
          color: ColorManager.primaryColor,
          size: Dimensions.s24,
        ),
      ),
    );
  }
}
