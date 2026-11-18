import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});

  static const _topics = [
    'Artemis II',
    'Starship',
    'James Webb',
    'Mars',
    'SpaceX',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final activeQuery = ref.watch(searchQueryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Topics',
          style: theme.textTheme.titleSmall?.copyWith(
            color: isDark ? scheme.onSurface : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final topic in _topics)
              _TopicChip(
                label: topic,
                isSelected: activeQuery.toLowerCase() == topic.toLowerCase(),
                onTap: () {
                  ref.read(searchQueryProvider.notifier).submit(topic);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isSelected
        ? scheme.primaryContainer
        : (isDark ? scheme.surfaceContainerHigh : Colors.white);

    final fgColor = isSelected
        ? scheme.onPrimaryContainer
        : (isDark ? scheme.onSurface : const Color(0xFF4A4E5A));

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up_rounded, size: 16, color: fgColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: fgColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
