import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/constants.dart';

class NavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  const NavBar({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileNavBar(onNavTap: onNavTap),
      tablet: (BuildContext context) => DesktopNavBar(onNavTap: onNavTap),
      desktop: (BuildContext context) => DesktopNavBar(onNavTap: onNavTap),
    );
  }
}

class DesktopNavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  const DesktopNavBar({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

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
                NavItem(title: 'Contact', onTap: () => onNavTap?.call(3)),
                const SizedBox(width: 24),
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

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
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => themeProvider.toggleTheme(),
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
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
