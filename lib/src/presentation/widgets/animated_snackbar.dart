import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedSnackBar extends StatefulWidget {
  final Text message;
  final Duration duration;
  final Icon icon;

  const AnimatedSnackBar({
    super.key,
    required this.message,
    required this.icon,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedSnackBar> createState() => _AnimatedSnackBarState();

  static void show({
    required BuildContext context,
    required Text message,
    required Icon icon,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    final snackBar = AnimatedSnackBar(
      message: message,
      icon: icon,
      duration: duration ?? const Duration(seconds: 3),
    );
    final overlayEntry = OverlayEntry(builder: (_) => snackBar);

    overlay.insert(overlayEntry);
  }
}

class _AnimatedSnackBarState extends State<AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: const Offset(0.0, 0.1),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 20.0,
      right: 20.0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.icon,
                      const SizedBox(width: 10),
                      Flexible(child: widget.message),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
