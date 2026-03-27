import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/home/presentation/pages/home_page.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart' as ats;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    
    // Fallback if platform brightness is unavailable, assume light
    final platformBrightness = MediaQuery.maybePlatformBrightnessOf(context) ?? Brightness.light;
    
    final isDark = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);
            
    final initTheme = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

    return ats.ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp(
          title: 'Portfolio Gravity',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const HomePage(),
        );
      },
    );
  }
}
