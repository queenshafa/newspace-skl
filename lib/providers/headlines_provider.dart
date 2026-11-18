import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/core/constants/space_topic.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SelectedCategoryNotifier extends Notifier<SpaceTopic> {
  @override
  SpaceTopic build() => SpaceTopic.general;

  void select(SpaceTopic topic) {
    state = topic;
  }
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, SpaceTopic>(
      SelectedCategoryNotifier.new,
    );

final headlinesProvider = FutureProvider.family<List<Article>, SpaceTopic>((
  ref,
  topic,
) {
  return ref
      .watch(newsRepositoryProvider)
      .getTopHeadlines(searchQuery: topic.query);
});
