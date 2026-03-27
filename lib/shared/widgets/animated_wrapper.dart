import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedSectionWrapper extends StatefulWidget {
  final Widget child;
  final int delayMs;

  const AnimatedSectionWrapper({
    super.key,
    required this.child,
    this.delayMs = 0,
  });

  @override
  State<AnimatedSectionWrapper> createState() => _AnimatedSectionWrapperState();
}

class _AnimatedSectionWrapperState extends State<AnimatedSectionWrapper> {
  bool _isDone = false;
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDone) return widget.child;

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.05) {
          if (widget.delayMs > 0) {
            Future.delayed(Duration(milliseconds: widget.delayMs), () {
              if (mounted) {
                setState(() {
                  _isVisible = true;
                });
              }
            });
          } else {
            if (mounted) {
              setState(() {
                _isVisible = true;
              });
            }
          }
        }
      },
      child: widget.child
          .animate(
            target: _isVisible ? 1 : 0,
            onComplete: (controller) {
              if (mounted) {
                setState(() {
                  _isDone = true;
                });
              }
            },
          )
          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
          .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut),
    );
  }
}
