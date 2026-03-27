import 'package:flutter/material.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../../../../shared/widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  void _scrollToSection(int index) {
    final keys = [heroKey, aboutKey, projectsKey, experienceKey, contactKey];
    if (index >= 0 && index < keys.length) {
      final context = keys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              toolbarHeight: 90,
              backgroundColor: Theme.of(
                context,
              ).scaffoldBackgroundColor.withOpacity(0.95),
              flexibleSpace: NavBar(onNavTap: _scrollToSection),
              elevation: 0,
              forceElevated: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  HeroSection(
                    key: heroKey,
                    onProjectsTap: () => _scrollToSection(2),
                    onContactTap: () => _scrollToSection(4),
                  ),
                  AboutSection(key: aboutKey),
                  ProjectsSection(key: projectsKey),
                  ExperienceSection(key: experienceKey),
                  ContactSection(key: contactKey),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
