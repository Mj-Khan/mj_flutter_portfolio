import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'gradient_text.dart'; // Which is actually now RetroText
import 'glass_card.dart';

class HeroSection extends StatelessWidget {
  final Color accent1;
  final Color accent2;
  final bool isDesktop;

  const HeroSection({
    super.key,
    required this.accent1,
    required this.accent2,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 900;

        return wide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _HeroText(a1: accent1, a2: accent2),
                  ),
                  const SizedBox(width: 80),
                  const Expanded(flex: 1, child: _HeroSideCard()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroText(a1: accent1, a2: accent2),
                  const SizedBox(height: 60),
                  const _HeroSideCard(),
                ],
              );
      },
    );
  }
}

class _HeroText extends StatelessWidget {
  final Color a1;
  final Color a2;

  const _HeroText({required this.a1, required this.a2});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '> ${PortfolioContent.heroLabel.toUpperCase()}',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 3,
            fontWeight: FontWeight.w800,
            color: a1, // Neon terminal green/accent
          ),
        ),
        const SizedBox(height: 24),
        RetroText(
          PortfolioContent.heroHeadline,
          style: const TextStyle(
            fontSize: 64,
            height: 1.1,
            fontWeight: FontWeight.w900,
          ),
          color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          shadowColor: a1, // High contrast trailing shadow
        ),
        const SizedBox(height: 40),
        Text(
          PortfolioContent.heroBio,
          style: TextStyle(
            fontSize: 18,
            height: 1.8,
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 20,
          children: PortfolioContent.metrics
              .map((m) => _Metric(m.value, m.label))
              .toList(),
        ),
      ],
    );
  }
}

class _HeroSideCard extends StatelessWidget {
  const _HeroSideCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final borderCol = isDark
        ? AppColors.retroBorderDark
        : AppColors.retroBorderLight;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  PortfolioContent.focusAreasTitle.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.retroBgDark
                      : AppColors.retroBgLight,
                  border: Border.all(
                    color: AppColors.available,
                    width: 2, // chunky border for available status
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8, // Square block
                      color: AppColors
                          .available, // Retro pure square pixel indication
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      PortfolioContent.availabilityLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.available,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ...PortfolioContent.focusAreas.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderCol,
                        width: 2,
                      ), // Boxy icon frame
                      color: isDark
                          ? AppColors.darkScaffold
                          : AppColors.lightScaffold,
                    ),
                    child: Icon(item.icon, color: accent, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '> ${item.label}', // Terminal prefix
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: isDark ? AppColors.neoMagenta : AppColors.lightAccent2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isDark ? AppColors.textMainDark : AppColors.textMainLight,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
