import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../../shared/widgets/responsive_section.dart';
import '../../../../core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ResponsiveSection(
      backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9), // Slight contrast bg
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          children: [
            AnimatedSectionWrapper(
              child: Text(
                "04. What's Next?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSectionWrapper(
              delayMs: 100,
              child: Text(
                "Get In Touch",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedSectionWrapper(
              delayMs: 200,
              child: Text(
                "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      color: Colors.grey.shade600,
                    ),
              ),
            ),
            const SizedBox(height: 50),
            AnimatedSectionWrapper(
              delayMs: 300,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  PremiumButton(
                    text: "Email Me",
                    icon: Icons.email_outlined,
                    onPressed: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: AppConstants.email,
                        query: 'subject=Hello from Portfolio',
                      );
                      if (await canLaunchUrl(emailLaunchUri)) {
                        await launchUrl(emailLaunchUri);
                      }
                    },
                  ),
                  PremiumButton(
                    text: "Download Resume",
                    icon: Icons.download_outlined,
                    onPressed: () async {
                      final Uri url = Uri.parse(AppConstants.resumeUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AnimatedSectionWrapper(
              delayMs: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(context, AppConstants.githubUrl, "https://cdn-icons-png.flaticon.com/512/733/733553.png", "GitHub"),
                  const SizedBox(width: 16),
                  _buildSocialIcon(context, AppConstants.linkedinUrl, "https://cdn-icons-png.flaticon.com/512/174/174857.png", "LinkedIn"),
                  const SizedBox(width: 16),
                  _buildSocialIcon(context, AppConstants.instagramUrl, "https://cdn-icons-png.flaticon.com/512/2111/2111463.png", "Instagram"),
                ],
              ),
            ),
          ],
        ),
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
