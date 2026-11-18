// import '../data/models/article.dart';

// TODO 10: Implementasi BookmarkProvider
// 1. Buat class BookmarkNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), panggil BookmarkStorage.getBookmarks()
// 3. Buat fungsi toggleBookmark(Article article) untuk menambah/menghapus artikel dari bookmark
// 4. Setelah mengubah list, panggil BookmarkStorage.saveBookmarks() untuk menyimpan ke local storage
// 5. Buat fungsi isBookmarked(Article article) untuk mengecek apakah artikel sudah ada di bookmark
// 6. Buat bookmarkProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/services/bookmark_storage.dart';
import 'package:news_app/providers/dependency_provider.dart';

class BookmarkNotifier extends AsyncNotifier<List<Article>> {
  // Siswi akan membuat AsyncNotifier untuk Riverpod
  BookmarkStorage get _storage => ref.read(bookmarkStorageProvider);

  @override
  Future<List<Article>> build() async {
    return await _storage.load();
  }

  bool isBookmarked(Article article) {
    final bookmarks = state.asData?.value ?? [];

    return bookmarks.any((item) => item.url == article.url);
  }

  Future<void> toggleBookmark(Article article) async {
    final List<Article> bookmarks = [...(state.asData?.value ?? <Article>[])];

    final isSaved = bookmarks.any((item) => item.url == article.url);

    if (isSaved) {
      bookmarks.removeWhere((item) => item.url == article.url);
    } else {
      bookmarks.insert(0, article);
    }

    state = AsyncData(bookmarks);

    await _storage.save(bookmarks);
  }
}

final bookmarksProvider =
    AsyncNotifierProvider<BookmarkNotifier, List<Article>>(
      BookmarkNotifier.new,
    );

// menyimpan status bookmark untuk satu artikel (berdasrkan URL)
// widget yang memakai ini hanya rebuild ketika status artikel tsb berubah
final isBookmarkedProvider = Provider.family<bool, String>((ref, url) {
  final bookmarks = ref.watch(bookmarksProvider).asData?.value ?? [];

  return bookmarks.any((article) => article.url == url);
});
