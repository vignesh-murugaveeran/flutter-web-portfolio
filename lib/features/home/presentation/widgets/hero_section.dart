import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../../core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onProjectsTap, this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      constraints: const BoxConstraints(maxWidth: AppConstants.desktopMaxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, I'm Vignesh Murugaveeran",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),
          const SizedBox(height: 24),
          Text(
            "Creative Flutter Developer.",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
          const SizedBox(height: 32),
          Text(
            "I build premium, scalable, and fully animated web applications.\nLet's create something extraordinary together.",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  height: 1.5,
                ),
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PremiumButton(
                text: "View Projects",
                icon: Icons.work_outline,
                onPressed: onProjectsTap ?? () {},
              ).animate().fadeIn(delay: 600.ms).scale(duration: 500.ms, curve: Curves.easeOutBack),
              TextButton(
                onPressed: onContactTap,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                ),
                child: const Text(
                  "Contact Me",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ).animate().fadeIn(delay: 700.ms),
              IconButton(
                onPressed: () async {
                  final url = Uri.parse(AppConstants.linkedinUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                icon: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/174/174857.png',
                  width: 32,
                  height: 32,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : null,
                ),
                tooltip: 'LinkedIn',
              ).animate().fadeIn(delay: 800.ms).scale(duration: 500.ms, curve: Curves.easeOutBack),
            ],
          ),
        ],
      ),
    );
  }
}
