import 'package:flutter/material.dart';
import '../../config/themes/styles.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.radiusSize,
    required this.height,
    required this.index,
    required this.icons,
    required this.backgroundColor,
    required this.hoverColor,
    required this.onTap,
    required this.onAnimatingEnd,
    required this.isAnimatingEnd,
  }) : super(key: key);

  final List<Icon> icons;
  final int index;
  final double radiusSize;
  final Color backgroundColor;
  final double height;
  final Color hoverColor;
  final Function(int index) onTap;
  final bool isAnimatingEnd;
  final VoidCallback onAnimatingEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusSize),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: isAnimatingEnd
                  ? Text(
                      "Pay",
                      style: TextStyles.whiteEncodeSansW800S18,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          icons.length,
                          (currentIndex) => BottomNavigationButton(
                            radiusSize: radiusSize,
                            backgroundColor: backgroundColor,
                            size: 40,
                            currentIndex: index,
                            icon: icons[currentIndex],
                            hoverColor: hoverColor,
                            onTap: () => onTap(currentIndex),
                            index: currentIndex,
                            onAnimatingEnd: onAnimatingEnd,
                          ),
                          growable: false,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    Key? key,
    required this.icon,
    required this.hoverColor,
    required this.size,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.backgroundColor,
    required this.radiusSize,
    required this.onAnimatingEnd,
  }) : super(key: key);

  final Icon icon;
  final Color backgroundColor;
  final Color hoverColor;
  final double size;
  final int index;
  final int currentIndex;
  final double radiusSize;
  final VoidCallback onTap;
  final VoidCallback onAnimatingEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: currentIndex == index ? size * 1.428 : size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSize),
          color: currentIndex == index ? hoverColor : backgroundColor,
        ),
        onEnd: onAnimatingEnd,
        child: icon,
      ),
    );
  }
}
