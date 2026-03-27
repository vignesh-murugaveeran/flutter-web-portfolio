import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveSection extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? customPadding;

  const ResponsiveSection({
    super.key,
    required this.child,
    this.backgroundColor,
    this.customPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: customPadding ??
          EdgeInsets.symmetric(
            horizontal: getValueForScreenType<double>(
              context: context,
              mobile: 24,
              tablet: 40,
              desktop: 80,
            ),
            vertical: getValueForScreenType<double>(
              context: context,
              mobile: 80,
              tablet: 100,
              desktop: 120,
            ),
          ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
