import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/bookmark_provider.dart';
import 'package:news_app/ui/screens/home/widgets/news_article_card.dart';

class BookmarkItem extends ConsumerWidget {
  const BookmarkItem({super.key, required this.article});

  final Article article;

  void _remove(BuildContext context, WidgetRef ref) {
    // Simpan referensi notifier sebelum widget di-unmount oleh Dismissible
    final notifier = ref.read(bookmarksProvider.notifier);
    notifier.toggleBookmark(article);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Dihapus dari Tersimpan'),
          action: SnackBarAction(
            label: 'Urungkan',
            onPressed: () {
              notifier.toggleBookmark(article);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(article.url),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _remove(context, ref),
      background: Container(
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(
          Icons.delete_outline_rounded,
          color: scheme.onErrorContainer,
        ),
      ),
      child: NewsArticleCard(article: article),
    );
  }
}
