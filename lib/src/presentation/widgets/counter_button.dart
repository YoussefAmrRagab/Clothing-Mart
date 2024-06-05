import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';
import '../../config/themes/dimens.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: Colors.black12,
            style: BorderStyle.solid,
            width: Dimensions.s1,
          ),
        ),
      ),
      onPressed: onTap,
      icon: Icon(
        icon,
        color: ColorManager.blackColor,
      ),
    );
  }
}
