import 'package:flutter/material.dart';
import '../../config/themes/colors.dart';

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    required this.text,
    required this.onClick,
    required this.isSelected,
  });

  final String text;
  final bool isSelected;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : ColorManager.blackColor,
          fontFamily: 'EncodeSans',
          fontWeight: FontWeight.w300,
        ),
      ),
      onSelected: (_) => onClick(),
      selectedColor: ColorManager.primaryColor,
      backgroundColor: Colors.white,
      side: BorderSide(color: ColorManager.secondaryColor),
      selected: isSelected,
      checkmarkColor: Colors.white,
    );
  }
}
