import 'package:material_ui/material_ui.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({
    super.key,
    required this.article,
    this.categoryLabel = 'SPACE NEWS',
  });

  final Article article;
  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Responsive card height.
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardHeight = (screenWidth * 1.2).clamp(420.0, 520.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: SizedBox(
        width: double.infinity,
        height: cardHeight,
        child: Material(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => AppRouter.openArticle(context, article),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                ArticleImage(url: article.imageUrl, radius: 0),

                // Gradient overlay
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.scrim.withValues(alpha: 0.65),
                        colors.scrim.withValues(alpha: 0.05),
                        colors.primary.withValues(alpha: 0.78),
                      ],
                      stops: const [0.0, 0.38, 1.0],
                    ),
                  ),
                ),

                // Bookmark button
                Positioned(
                  top: 16,
                  right: 16,
                  child: Material(
                    color: colors.surface.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(10),
                    child: BookmarkButton(article: article),
                  ),
                ),

                // Article information
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 18,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category label
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          categoryLabel,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colors.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Headline
                      Text(
                        article.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Publisher and publication date
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.sourceName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colors.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  DateFormatter.relative(article.publishedAt),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colors.onPrimary.withValues(
                                      alpha: 0.85,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Publisher initials
                          Container(
                            width: 42,
                            height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _publisherInitials(article.sourceName),
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: colors.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _publisherInitials(String name) {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) return '?';

    if (words.length == 1) {
      return words.first
          .substring(0, words.first.length >= 2 ? 2 : 1)
          .toUpperCase();
    }

    return '${words.first[0]}${words[1][0]}'.toUpperCase();
  }
}
