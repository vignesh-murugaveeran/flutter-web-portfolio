import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSectionWrapper extends StatelessWidget {
  final Widget child;
  final int delayMs;

  const AnimatedSectionWrapper({
    super.key,
    required this.child,
    this.delayMs = 0,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delayMs.ms)
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}
