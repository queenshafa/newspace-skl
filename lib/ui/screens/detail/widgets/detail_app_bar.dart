import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

/// App bar dengan gambar hero melengkung di bagian bawah.
class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key, required this.article});

  final Article article;

  String get _badgeLabel {
    if (article.launches.isNotEmpty) return 'Launch';
    if (article.events.isNotEmpty) return 'Event';
    if (article.featured) return 'Featured';
    return 'Space News';
  }

  int get _readingTime {
    final text = article.cleanContent.isNotEmpty
        ? article.cleanContent
        : (article.description ?? article.title);

    final wordCount = text.trim().isEmpty
        ? 0
        : text.trim().split(RegExp(r'\s+')).length;

    return (wordCount / 200).ceil().clamp(1, 999);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final accentPastel = isDark ? scheme.primary : scheme.inversePrimary;
    final collapsedBg = isDark
        ? scheme.surfaceContainerHighest
        : const Color(0xFF8C9EC9);

    const bottomRadius = BorderRadius.vertical(bottom: Radius.circular(36));

    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 390,
      backgroundColor: collapsedBg,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: bottomRadius),
      leadingWidth: 64,
      leading: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Material(
            color: accentPastel,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Center(
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: accentPastel,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButtonTheme(
              data: IconButtonThemeData(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 40),
                  maximumSize: const Size(40, 40),
                  foregroundColor: Colors.white,
                  iconSize: 22,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white, size: 22),
                child: BookmarkButton(article: article),
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: ClipRRect(
          borderRadius: bottomRadius,
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
                    colors: isDark
                        ? [
                            Colors.black.withValues(alpha: 0.65),
                            Colors.black.withValues(alpha: 0.2),
                            scheme.surfaceContainerHighest.withValues(
                              alpha: 0.88,
                            ),
                            scheme.surfaceContainerHighest,
                          ]
                        : [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.black.withValues(alpha: 0.15),
                            const Color(0xFF6E7FA8).withValues(alpha: 0.8),
                            const Color(0xFF8C9EC9).withValues(alpha: 0.94),
                          ],
                    stops: const [0.0, 0.36, 0.72, 1.0],
                  ),
                ),
              ),

              // Kategori pill, waktu baca, dan judul artikel
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: accentPastel,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _badgeLabel,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '$_readingTime min read  |  ${DateFormatter.relative(article.publishedAt)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      article.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
