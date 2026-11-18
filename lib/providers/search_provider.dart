// import '../data/models/article.dart';

// TODO 9: Implementasi SearchProvider
// 1. Buat class SearchNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), return [] sebagai nilai awal
// 3. Buat fungsi search(String query) untuk memanggil NewsRepository.searchArticles() dan menyimpan hasilnya di state
// 4. Buat searchProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  //akan dijalankan ketika user klik tombol enter
  void submit(String query) => state = query.trim();

  void clear() => state = '';
}

//pendefinisian dari class ke variabel
final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

//mengatur hasil pencarian : otomatis fetch ulang setiap kali query berubah
final searchResultProvider = FutureProvider.autoDispose<List<Article>>((
  ref,
) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  return ref.watch(newsRepositoryProvider).searchArticles(query);
});

//alias agar dapat di akses dengan nama searchResultProvider maupun searchResultsProvider
final searchResultsProvider = searchResultProvider;
