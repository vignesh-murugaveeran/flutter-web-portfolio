import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../../shared/widgets/responsive_section.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onProjectsTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSection(
      customPadding: EdgeInsets.symmetric(
        horizontal: getValueForScreenType<double>(context: context, mobile: 24, tablet: 40, desktop: 80),
        vertical: 100, // Hero specific vertical padding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSectionWrapper(
            child: Text(
              "Hello, I'm Vignesh Murugaveeran",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: getValueForScreenType<double>(context: context, mobile: 16, tablet: 20, desktop: 24),
                  ),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedSectionWrapper(
            delayMs: 200,
            child: Text(
              "Flutter Developer.",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    letterSpacing: -1.5,
                    fontSize: getValueForScreenType<double>(context: context, mobile: 36, tablet: 56, desktop: 72),
                  ),
            ),
          ),
          const SizedBox(height: 32),
          AnimatedSectionWrapper(
            delayMs: 400,
            child: Text(
              AppConstants.heroTagline,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    height: 1.5,
                    fontSize: getValueForScreenType<double>(context: context, mobile: 16, tablet: 18, desktop: 20),
                  ),
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AnimatedSectionWrapper(
                delayMs: 600,
                child: PremiumButton(
                  text: "View Projects",
                  icon: Icons.work_outline,
                  onPressed: onProjectsTap ?? () {},
                ),
              ),
              AnimatedSectionWrapper(
                delayMs: 700,
                child: TextButton(
                  onPressed: onContactTap,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  ),
                  child: const Text(
                    "Contact Me",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AnimatedSectionWrapper(
                delayMs: 800,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSocialIcon(context, AppConstants.githubUrl, "https://cdn-icons-png.flaticon.com/512/733/733553.png", "GitHub"),
                    const SizedBox(width: 12),
                    _buildSocialIcon(context, AppConstants.linkedinUrl, "https://cdn-icons-png.flaticon.com/512/174/174857.png", "LinkedIn"),
                    const SizedBox(width: 12),
                    _buildSocialIcon(context, AppConstants.instagramUrl, "https://cdn-icons-png.flaticon.com/512/2111/2111463.png", "Instagram"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, String url, String iconUrl, String tooltip) {
    return IconButton(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      icon: Image.network(
        iconUrl,
        width: 28,
        height: 28,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null,
      ),
      tooltip: tooltip,
    );
  }
}

