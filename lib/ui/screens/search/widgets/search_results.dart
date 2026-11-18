import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/ui/screens/home/widgets/news_article_card.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final selectedTopic = ref.watch(selectedCategoryProvider);

    // Jika query kosong, tampilkan berita sesuai CategoryChips yang dipilih
    final articlesAsync = query.isEmpty
        ? ref.watch(headlinesProvider(selectedTopic))
        : ref.watch(searchResultProvider);

    return articlesAsync.when(
      loading: () => const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: LoadingSkeleton(),
      ),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () {
          if (query.isEmpty) {
            ref.invalidate(headlinesProvider(selectedTopic));
          } else {
            ref.invalidate(searchResultProvider);
          }
        },
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'Tidak ada hasil',
            message: 'Coba kata kunci lain atau periksa ejaan anda',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
          itemCount: articles.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, index) => NewsArticleCard(article: articles[index]),
        );
      },
    );
  }
}
