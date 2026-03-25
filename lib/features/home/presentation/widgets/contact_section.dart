import 'package:flutter/material.dart';
import '../../../../shared/widgets/animated_wrapper.dart';
import '../../../../shared/widgets/premium_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9), // Slight contrast bg
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              AnimatedSectionWrapper(
                child: Text(
                  "03. What's Next?",
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
                child: PremiumButton(
                  text: "Say Hello",
                  icon: Icons.email_outlined,
                  onPressed: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'hello@example.com',
                      query: 'subject=Hello from Portfolio',
                    );
                    if (!await launchUrl(emailLaunchUri)) {
                      throw Exception('Could not launch email');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
