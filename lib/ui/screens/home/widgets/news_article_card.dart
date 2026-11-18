import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

import 'package:news_app/core/router/app_router.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/ui/widgets/article_image.dart';
import 'package:news_app/ui/widgets/bookmark_button.dart';

class NewsArticleCard extends StatelessWidget {
  const NewsArticleCard({super.key, required this.article});

  final Article article;

  // Smart tag otomatis berdasarkan metadata SNAPI v4.
  String get badgeLabel {
    if (article.launches.isNotEmpty) return 'Launch';
    if (article.events.isNotEmpty) return 'Event';
    if (article.featured) return 'Featured';
    return 'Space News';
  }

  // Format tanggal publikasi ("Nov, 23 2026").
  String get formattedDate {
    if (article.publishedAt == null) {
      return 'Recently';
    }

    return DateFormat('MMM, d yyyy', 'en_US').format(article.publishedAt!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Warna pastel periwinkle turunan langsung dari seedColor (#B4C2E8)
    final accentPastel = isDark ? scheme.primary : scheme.inversePrimary;
    final cardSurface = isDark
        ? scheme.surfaceContainerLow
        : Color.alphaBlend(
            scheme.primary.withValues(alpha: 0.03),
            scheme.surface,
          );
    final cardBorder = isDark ? scheme.outlineVariant : scheme.primaryContainer;

    return Material(
      color: cardSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: cardBorder, width: 1.3),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => AppRouter.openArticle(context, article),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ARTICLE THUMBNAIL
              SizedBox(
                width: 112,
                height: 112,
                child: ArticleImage(url: article.imageUrl, radius: 16),
              ),

              const SizedBox(width: 14),

              // ARTICLE INFORMATION
              Expanded(
                child: SizedBox(
                  height: 112,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SMART TAG PILL + BOOKMARK BOX
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: accentPastel,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.zero,
                                  ),
                                ),
                                child: Text(
                                  badgeLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // BOOKMARK BUTTON (Di ujung kanan)
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: accentPastel,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButtonTheme(
                              data: IconButtonThemeData(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(34, 34),
                                  maximumSize: const Size(34, 34),
                                  foregroundColor: Colors.white,
                                  iconSize: 20,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              child: IconTheme(
                                data: const IconThemeData(
                                  color: Colors.white,
                                  size: 20,
                                ),
                                child: BookmarkButton(article: article),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ARTICLE TITLE
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            letterSpacing: -0.2,
                            color: scheme.onSurface,
                          ),
                        ),
                      ),

                      // SOURCE + DATE
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.sourceName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: scheme.onSurfaceVariant.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            formattedDate,
                            maxLines: 1,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                              color: scheme.onSurfaceVariant.withValues(
                                alpha: 0.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
