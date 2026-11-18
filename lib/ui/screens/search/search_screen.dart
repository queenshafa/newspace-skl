import 'package:material_ui/material_ui.dart';
import 'package:news_app/ui/screens/home/widgets/category_chips.dart';

import 'widgets/search_input.dart';
import 'widgets/search_results.dart';
import 'widgets/search_suggestions.dart';

/// Halaman Jelajahi: header biru-lavender + sheet putih berisi kategori & artikel.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Warna header sesuai seed color #B4C2E8 (adaptif untuk dark mode)
    final headerColor = isDark
        ? scheme.surfaceContainerHighest
        : const Color(0xFFB4C2E8);

    return Scaffold(
      backgroundColor: headerColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BAGIAN ATAS: Discover, Search Bar, Top Topics
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: isDark ? scheme.onSurface : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore space news, missions, and topics',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? scheme.onSurfaceVariant
                          : Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SearchInput(),
                  const SizedBox(height: 20),
                  const SearchSuggestions(),
                ],
              ),
            ),

            // BAGIAN BAWAH: Sheet Putih Melengkung + Category Chips + Articles
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    CategoryChips(),
                    SizedBox(height: 4),
                    Expanded(child: SearchResults()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
