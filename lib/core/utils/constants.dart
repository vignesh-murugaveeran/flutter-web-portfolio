import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> techStack;
  final String problemStatement;
  final String role;
  final List<String> features;
  final String impact;
  final String liveUrl;
  final String githubUrl;
  final String imagePath; // Placeholder if needed

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    required this.problemStatement,
    required this.role,
    required this.features,
    required this.impact,
    this.liveUrl = "https://example.com",
    this.githubUrl = "https://github.com",
    this.imagePath = "",
  });
}

class ExperienceModel {
  final String company;
  final String role;
  final String duration;
  final String description;
  final List<String> challengesSolved;

  const ExperienceModel({
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    required this.challengesSolved,
  });
}

class AppConstants {
  static const double desktopMaxWidth = 1200;
  static const String profileImage = 'assets/portfolio_photo.jpeg';

  // Taglines and Texts
  static const String heroTagline =
      "Flutter Developer building scalable apps with clean architecture & smooth UX.";
  static const String aboutMeText =
      "I craft scalable, pixel-perfect Flutter applications that bridge the gap between elegant user interfaces and robust backend architectures. With a deep focus on clean code and interactive design, I transform complex engineering problems into intuitive digital experiences.";
  static const String aboutGoalText =
      "My goal: To build products that genuinely solve problems, while maintaining clean, maintainable, and highly-tested codebases.";

  // Links
  static const String githubUrl = "https://github.com/vc345companywrk-sys";
  static const String linkedinUrl =
      "https://linkedin.com/in/vignesh-murugaveeran";
  static const String instagramUrl =
      "https://www.instagram.com/vickym34578?igsh=MWZ6dGoxa2twdHk2dw==";
  static const String email = "hello@example.com";
  static const String resumeUrl = "https://example.com/resume.pdf";

  // Categorized Skills
  static const Map<String, List<String>> categorizedSkills = {
    "Frontend": ["Flutter", "Dart", "Basic HTML/CSS"],
    "Backend": ["Node.js", "Express", "REST APIs"],
    "State Management": ["Riverpod", "GetX", "Provider", "BLoC"],
    "Database": ["MongoDB", "PostgreSQL", "SQLite"],
    "Tools": ["Git", "Postman", "Figma", "CI/CD"],
  };

  // Detailed Projects
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: "E-Commerce App",
      description:
          "A massively scalable e-commerce application built with Flutter & Firebase. Features real-time cart synchronization across multiple devices.",
      techStack: ["Flutter", "Firebase", "Stripe", "Riverpod"],
      problemStatement:
          "The client needed a real-time reactive cart system to operate flawlessly across low-bandwidth environments without dropping transactions.",
      role:
          "Lead Mobile Developer - Architected the entire state tree and checkout flow.",
      features: [
        "Offline-first caching",
        "Stripe seamless checkout",
        "Real-time stock polling",
        "Algolia Search",
      ],
      impact:
          "Reduced checkout abandonment by 40% and improved image rendering speeds by intelligently caching network responses.",
      githubUrl: "https://github.com",
      liveUrl: "https://example-ecommerce.com",
    ),
    ProjectModel(
      title: "Task Manager Pro",
      description:
          "Advanced productivity tool with offline-first capabilities using Isar Database and Riverpod.",
      techStack: ["Flutter", "Isar", "Freezed", "GetX"],
      problemStatement:
          "Users were suffering from slow list load times on older devices and wanted absolute privacy with offline functionality.",
      role:
          "Sole Developer - Built front-to-back focusing deeply on database query optimizations.",
      features: [
        "0ms latency UI updates",
        "Local notifications",
        "Complex filtering queries",
        "Backup to drive",
      ],
      impact:
          "Engineered ultra-fast pagination bypassing API bottlenecks. Achieved consistent 60fps scrolling on massive lists.",
    ),
    ProjectModel(
      title: "Social Dashboard Web",
      description:
          "Responsive web dashboard for social media analytics, crafted with Flutter Web and interactive charts.",
      techStack: ["Flutter Web", "Charts", "GraphQL"],
      problemStatement:
          "Data aggregation across 5 different social APIs was crashing the single-threaded JS client the company originally had.",
      role:
          "Frontend Engineer - Migrated the dashboard to Flutter Web to leverage compile-time safety and isolations.",
      features: [
        "Custom interactive web charts",
        "Responsive sidebar",
        "Debounced API calls",
        "Token refresh secure interceptors",
      ],
      impact:
          "Optimized complex API calls using debouncing and background parsing, cutting load times by 60%.",
    ),
    ProjectModel(
      title: "Instagram clone App",
      description:
          "Responsive web dashboard for social media analytics, crafted with Flutter Web and interactive charts.",
      techStack: ["Flutter Web", "Charts", "GraphQL"],
      problemStatement:
          "Data aggregation across 5 different social APIs was crashing the single-threaded JS client the company originally had.",
      role:
          "Frontend Engineer - Migrated the dashboard to Flutter Web to leverage compile-time safety and isolations.",
      features: [
        "Custom interactive web charts",
        "Responsive sidebar",
        "Debounced API calls",
        "Token refresh secure interceptors",
      ],
      impact:
          "Optimized complex API calls using debouncing and background parsing, cutting load times by 60%.",
    ),
    ProjectModel(
      title: "Expense Tracket App",
      description:
          "Responsive web dashboard for social media analytics, crafted with Flutter Web and interactive charts.",
      techStack: ["Flutter Web", "Charts", "GraphQL"],
      problemStatement:
          "Data aggregation across 5 different social APIs was crashing the single-threaded JS client the company originally had.",
      role:
          "Frontend Engineer - Migrated the dashboard to Flutter Web to leverage compile-time safety and isolations.",
      features: [
        "Custom interactive web charts",
        "Responsive sidebar",
        "Debounced API calls",
        "Token refresh secure interceptors",
      ],
      impact:
          "Optimized complex API calls using debouncing and background parsing, cutting load times by 60%.",
    ),
    ProjectModel(
      title: "Music Player App",
      description:
          "Responsive web dashboard for social media analytics, crafted with Flutter Web and interactive charts.",
      techStack: ["Flutter Web", "Charts", "GraphQL"],
      problemStatement:
          "Data aggregation across 5 different social APIs was crashing the single-threaded JS client the company originally had.",
      role:
          "Frontend Engineer - Migrated the dashboard to Flutter Web to leverage compile-time safety and isolations.",
      features: [
        "Custom interactive web charts",
        "Responsive sidebar",
        "Debounced API calls",
        "Token refresh secure interceptors",
      ],
      impact:
          "Optimized complex API calls using debouncing and background parsing, cutting load times by 60%.",
    ),
  ];

  // Experience & Problem Solving
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: "Silgate Solutions",
      role: "Flutter Developer",
      duration: "Nov 2025 - Present",
      description:
          "Leading the mobile transformation for enterprise clients, architecting solutions that scale to thousands of DAU.",
      challengesSolved: [
        "Fixed multiple redundant API calls in complex pagination flows using RxDart stream debouncing.",
        "Handled OAuth token refresh securely with automated Dio interceptors and secure storage.",
        "Refactored legacy Provider spaghetti code into heavily tested Riverpod architecture.",
      ],
    ),
    ExperienceModel(
      company: "Freelance",
      role: "Full-Stack Developer",
      duration: "Jun 2025 - Present",
      description:
          "Delivered end-to-end applications for local startups, from wireframe to deployment.",
      challengesSolved: [
        "Optimized massive image asset pipelines, saving 70% of cloud bucket egress costs.",
        "Built custom animated routing to improve UX perception without relying on heavy packages.",
      ],
    ),
  ];
}
