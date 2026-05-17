import 'package:flutter/material.dart';
import 'package:mj_flutter_portfolio/core/app_colors.dart';
import 'package:mj_flutter_portfolio/data/app_data.dart';
import 'package:mj_flutter_portfolio/data/content_repository.dart';
import 'package:mj_flutter_portfolio/data/site_config_repository.dart';
import 'package:mj_flutter_portfolio/screens/resume_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load repositories sequentially to avoid a DDC (Dart web compiler) bug
  // where nested concurrent Future.wait calls share an internal completion
  // array and produce RangeError index crashes on web.
  final content = await ContentRepository.load();
  final siteConfig = await SiteConfigRepository.load();

  runApp(
    AppData(
      content: content,
      siteConfig: siteConfig,
      child: const ResumeApp(),
    ),
  );
}

class ResumeApp extends StatefulWidget {
  const ResumeApp({super.key});

  @override
  State<ResumeApp> createState() => _ResumeAppState();
}

class _ResumeAppState extends State<ResumeApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdul Mujeeb - Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightScaffold,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkScaffold,
        useMaterial3: true,
      ),
      home: ResumeHome(
        isDark: isDark,
        onToggleTheme: (v) => setState(() => isDark = v),
      ),
      // ── Loading / Error UI ─────────────────────────────────────────────
      // Both repositories are loaded synchronously before runApp so the app
      // never renders in a half-loaded state. If the Future.wait above throws,
      // the error is surfaced via the builder below (registered via
      // FlutterError.onError / ErrorWidget.builder for any in-tree errors).
      builder: (context, child) {
        // Catch any in-tree errors that escape to the root.
        ErrorWidget.builder = (details) => _AppErrorWidget(details: details);
        return child!;
      },
    );
  }
}

/// Graceful fallback shown if any widget subtree throws an uncaught error.
/// Shows the error message in debug builds; a generic message in release.
class _AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails details;

  const _AppErrorWidget({required this.details});

  @override
  Widget build(BuildContext context) {
    const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;

    return Scaffold(
      backgroundColor: AppColors.darkScaffold,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Color(0xFFFF6B6B),
              ),
              const SizedBox(height: 24),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isDebug
                    ? details.exceptionAsString()
                    : 'Please refresh the page.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
