import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/screens/home/widgets/featured_article_card.dart';
import 'package:news_app/ui/screens/home/widgets/news_article_card.dart';

class HeadlinesSection extends ConsumerWidget {
  const HeadlinesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTopic = ref.watch(selectedCategoryProvider);

    final headlines = ref.watch(headlinesProvider(selectedTopic));

    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: headlines.when(
        // LOADING STATE
        loading: () => const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),

        // ERROR STATE
        error: (error, stack) => Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 40,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'Berita belum bisa ditampilkan',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(headlinesProvider(selectedTopic));
                  },
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),

        // DATA STATE
        data: (articles) {
          if (articles.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text('Belum ada berita ditemukan.')),
            );
          }

          // Hanya satu artikel sebagai Featured Article.
          final featuredArticle = articles.first;

          // Semua artikel berikutnya masuk Latest News.
          final latestArticles = articles.skip(1).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FEATURED ARTICLE
              FeaturedArticleCard(article: featuredArticle),

              // LATEST NEWS HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
                child: Text(
                  'Latest News',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // LATEST NEWS ARTICLES
              if (latestArticles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: latestArticles.map((article) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: NewsArticleCard(article: article),
                      );
                    }).toList(),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Text(
                    'Belum ada berita lainnya.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
