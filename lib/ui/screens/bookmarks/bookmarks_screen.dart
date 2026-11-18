import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/bookmark_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(bookmarksProvider);
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
            // BAGIAN ATAS: Header Saved Articles
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Saved Articles',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: isDark ? scheme.onSurface : Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconTheme(
                        data: IconThemeData(
                          color: isDark ? scheme.onSurface : Colors.white,
                        ),
                        child: const ThemeToggleButton(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your bookmarked space stories and updates',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? scheme.onSurfaceVariant
                          : Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            // BAGIAN BAWAH: Sheet Putih Melengkung + Daftar Bookmark
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
                child: bookmarksAsync.when(
                  // Saat data sedang dimuat
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),

                  // Saat terjadi error
                  error: (error, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'Gagal memuat bookmark: $error',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // Saat data berhasil dimuat
                  data: (bookmarks) {
                    if (bookmarks.isEmpty) {
                      return const EmptyState(
                        icon: Icons.bookmark_border_rounded,
                        title: 'Belum ada berita tersimpan',
                        message: 'Ketuk ikon bookmark pada berita\nuntuk membacanya nanti.',
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                      itemCount: bookmarks.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        return BookmarkItem(article: bookmarks[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
