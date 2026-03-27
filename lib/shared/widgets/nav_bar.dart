import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/constants.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart' as ats;
import '../../core/theme/app_theme.dart';

class NavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  const NavBar({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileNavBar(onNavTap: onNavTap),
      tablet: (BuildContext context) => MobileNavBar(onNavTap: onNavTap), // Use MobileNavBar on tablet to prevent row overflow
      desktop: (BuildContext context) => DesktopNavBar(onNavTap: onNavTap),
    );
  }
}

class DesktopNavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  const DesktopNavBar({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.desktopMaxWidth,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Portfolio.',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            Row(
              children: [
                NavItem(title: 'Home', onTap: () => onNavTap?.call(0)),
                NavItem(title: 'About', onTap: () => onNavTap?.call(1)),
                NavItem(title: 'Projects', onTap: () => onNavTap?.call(2)),
                NavItem(title: 'Experience', onTap: () => onNavTap?.call(3)),
                NavItem(title: 'Contact', onTap: () => onNavTap?.call(4)),
                const SizedBox(width: 24),
                const ThemeToggleButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MobileNavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  const MobileNavBar({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Portfolio.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          Row(
            children: [
              const ThemeToggleButton(),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Fallback for mobile scrolling
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(title: const Text('Home'), onTap: () { Navigator.pop(ctx); onNavTap?.call(0); }),
                          ListTile(title: const Text('About'), onTap: () { Navigator.pop(ctx); onNavTap?.call(1); }),
                          ListTile(title: const Text('Projects'), onTap: () { Navigator.pop(ctx); onNavTap?.call(2); }),
                          ListTile(title: const Text('Experience'), onTap: () { Navigator.pop(ctx); onNavTap?.call(3); }),
                          ListTile(title: const Text('Contact'), onTap: () { Navigator.pop(ctx); onNavTap?.call(4); }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const NavItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return ats.ThemeSwitcher(
      builder: (context) {
        final currentTheme = Theme.of(context);
        final isDark = currentTheme.brightness == Brightness.dark;

        return IconButton(
          onPressed: () {
            final newTheme = isDark ? AppTheme.lightTheme : AppTheme.darkTheme;
            
            ats.ThemeSwitcher.of(context).changeTheme(
              theme: newTheme,
              isReversed: isDark,
            );
            
            // Sync with our custom provider
            themeProvider.setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(
                turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              );
            },
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey<bool>(isDark),
            ),
          ),
        );
      },
    );
  }
}
