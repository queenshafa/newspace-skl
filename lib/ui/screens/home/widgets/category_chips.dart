import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/core/constants/space_topic.dart';
import 'package:news_app/providers/headlines_provider.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = SpaceTopic.values;

    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final topic = categories[index];

          return ChoiceChip(
            label: Text(topic.label),
            selected: topic == selected,
            showCheckmark: false,
            onSelected: (_) {
              ref.read(selectedCategoryProvider.notifier).select(topic);
            },
          );
        },
      ),
    );
  }
}
