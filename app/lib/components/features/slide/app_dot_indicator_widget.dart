import 'package:flutter/material.dart';

class AppDotIndicatorWidget extends StatelessWidget {
  const AppDotIndicatorWidget({
    super.key,
    this.isActive = false,
    this.height = 4,
    this.width = 4,
    this.child,
    this.activeColor,
  });

  final bool isActive;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? height : 4,
      width: width,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor ?? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child ?? const SizedBox(),
        ],
      ),
    );
  }
}
