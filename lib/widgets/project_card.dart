import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';
import '../models/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final IconData icon;

  const ProjectCard({super.key, required this.project, required this.icon});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkAccent1 : AppColors.lightAccent1;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: _hovered
                  ? AppColors.glassBorderHover
                  : AppColors.glassBorder,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: AppColors.glassDarkShadow)
                  : Colors.black.withValues(alpha: AppColors.glassLightShadow),
              blurRadius: _hovered ? 40 : 20,
              offset: const Offset(0, 10),
            ),
          ],
          gradient: LinearGradient(
            colors: isDark
                ? [
                    Colors.white.withValues(
                        alpha: p.isDetailsPending ? 0.04 : 0.08),
                    Colors.white.withValues(
                        alpha: p.isDetailsPending ? 0.01 : 0.03),
                  ]
                : [
                    Colors.white.withValues(
                        alpha: p.isDetailsPending ? 0.20 : 0.35),
                    Colors.white.withValues(
                        alpha: p.isDetailsPending ? 0.08 : 0.15),
                  ],
          ),
        ),
        // Reduce opacity on details_pending cards to signal "inactive"
        child: Opacity(
          opacity: p.isDetailsPending ? 0.65 : 1.0,
          child: p.isDetailsPending
              ? _PendingCardBody(project: p, icon: widget.icon, accent: accent)
              : _FullCardBody(
                  project: p,
                  icon: widget.icon,
                  accent: accent,
                  isDark: isDark,
                ),
        ),
      ),
    );
  }
}

// ─── Full card (status: live / internal / regional_only) ──────────────────

class _FullCardBody extends StatelessWidget {
  final Project project;
  final IconData icon;
  final Color accent;
  final bool isDark;

  const _FullCardBody({
    required this.project,
    required this.icon,
    required this.accent,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final p = project;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 36, color: accent),
        const SizedBox(height: 24),
        Text(
          p.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        if (p.tagline != null) ...[
          const SizedBox(height: 8),
          Text(
            p.tagline!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: accent,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Text(
          p.shortDescription ?? '',
          style: const TextStyle(height: 1.6),
        ),
        // Store metadata (hidden when null)
        if (p.storeMetadata != null) ...[
          const SizedBox(height: 16),
          _StoreMetadataRow(meta: p.storeMetadata!, accent: accent),
        ],
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: p.techStack.map((c) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                c,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        if (p.primaryLink != null) ...[
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(p.primaryLink!.url);
              if (await canLaunchUrl(uri)) launchUrl(uri);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.link, size: 18, color: accent),
                const SizedBox(width: 8),
                Text(
                  _linkLabel(p.primaryLink!.type),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  static String _linkLabel(String type) {
    switch (type) {
      case 'play_store':
        return 'Play Store';
      case 'app_store':
        return 'App Store';
      case 'website':
        return 'Website';
      default:
        return 'View';
    }
  }
}

// ─── Store metadata row ────────────────────────────────────────────────────

class _StoreMetadataRow extends StatelessWidget {
  final StoreMetadata meta;
  final Color accent;

  const _StoreMetadataRow({required this.meta, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        if (meta.rating != null)
          _MetaChip(
            icon: Icons.star_rounded,
            label: meta.rating!.toStringAsFixed(1),
            accent: accent,
          ),
        _MetaChip(
          icon: Icons.download_rounded,
          label: meta.downloadsLabel,
          accent: accent,
        ),
        if (meta.reviewCount != null)
          _MetaChip(
            icon: Icons.rate_review_outlined,
            label: '${meta.reviewCount} reviews',
            accent: accent,
          ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: accent.withValues(alpha: 0.7)),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

// ─── Pending card (status: details_pending) ────────────────────────────────

class _PendingCardBody extends StatelessWidget {
  final Project project;
  final IconData icon;
  final Color accent;

  const _PendingCardBody({
    required this.project,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 36, color: accent.withValues(alpha: 0.6)),
        const SizedBox(height: 24),
        Text(
          project.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        // "Coming Soon" badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFFFB74D).withValues(alpha: 0.15),
            border: Border.all(
              color: const Color(0xFFFFB74D).withValues(alpha: 0.4),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 12,
                color: Color(0xFFFFB74D),
              ),
              SizedBox(width: 6),
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFB74D),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Project details are on their way.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
