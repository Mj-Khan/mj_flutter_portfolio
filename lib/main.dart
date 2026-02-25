import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_flutter_portfolio/core/app_colors.dart';
import 'package:mj_flutter_portfolio/screens/resume_home.dart';

void main() {
  runApp(const ResumeApp());
}

class ResumeApp extends StatefulWidget {
  const ResumeApp({super.key});

  @override
  State<ResumeApp> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  // Start in dark mode by default
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdul Mujeeb - Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        textTheme: GoogleFonts.vt323TextTheme(ThemeData.light().textTheme),
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightScaffold,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.vt323TextTheme(ThemeData.dark().textTheme),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkScaffold,
        useMaterial3: true,
      ),
      home: ResumeHome(
        isDark: isDark,
        onToggleTheme: (v) => setState(() => isDark = v),
      ),
    );
  }
}
