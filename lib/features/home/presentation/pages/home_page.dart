import 'package:flutter/material.dart';
import '../../../../shared/widgets/nav_bar.dart';
import '../../../../shared/widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
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
  final contactKey = GlobalKey();

  void _scrollToSection(int index) {
    final keys = [heroKey, aboutKey, projectsKey, contactKey];
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            toolbarHeight: 90,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
            flexibleSpace: NavBar(onNavTap: _scrollToSection),
            elevation: 0,
            forceElevated: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HeroSection(
                key: heroKey,
                onProjectsTap: () => _scrollToSection(2),
                onContactTap: () => _scrollToSection(3),
              ),
              AboutSection(key: aboutKey),
              ProjectsSection(key: projectsKey),
              ContactSection(key: contactKey),
              const Footer(),
            ]),
          ),
        ],
      ),
    );
  }
}
