import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../portfolio_content.dart';
import 'gradient_text.dart';
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
                  Expanded(flex: 1, child: const _HeroSideCard()),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioContent.heroLabel,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 24),
        GradientText(
          PortfolioContent.heroHeadline,
          style: const TextStyle(
            fontSize: 64,
            height: 1.1,
            fontWeight: FontWeight.w800,
          ),
          colors: [a1, a2],
        ),
        const SizedBox(height: 40),
        const Text(
          PortfolioContent.heroBio,
          style: TextStyle(fontSize: 18, height: 1.8),
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

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  PortfolioContent.focusAreasTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
                  color: AppColors.available.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.available.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.available,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      PortfolioContent.availabilityLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.available,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...PortfolioContent.focusAreas.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: accent.withValues(alpha: 0.12),
                    ),
                    child: Icon(item.icon, color: accent, size: 18),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item.label,
                      style: const TextStyle(fontSize: 14, height: 1.4),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade500)),
      ],
    );
  }
}
