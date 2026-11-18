import 'package:material_ui/material_ui.dart';

import '../../../../data/models/article.dart';

/// Ringkasan artikel + kotak catatan trailer.
class DetailContent extends StatelessWidget {
  const DetailContent({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final description = article.description ?? '';
    final content = article.cleanContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description.isNotEmpty)
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 15.5,
              height: 1.65,
              color: scheme.onSurface.withValues(alpha: 0.88),
            ),
          ),
        if (content.isNotEmpty && content != description) ...[
          const SizedBox(height: 16),
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 15.5,
              height: 1.65,
              color: scheme.onSurface.withValues(alpha: 0.88),
            ),
          ),
        ],
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: scheme.primaryContainer, width: 1.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.info_outline_rounded, color: scheme.primary, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'This is a trailer. Read the full article on ${article.sourceName}.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
