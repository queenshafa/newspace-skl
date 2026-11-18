import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/url_helper.dart';

/// Tombol "Read full article" yang menempel di bawah layar.
class ReadMoreBar extends StatelessWidget {
  const ReadMoreBar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final buttonColor = isDark ? scheme.primary : scheme.inversePrimary;

    return Container(
      color: scheme.surface,
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: const Icon(Icons.open_in_new_rounded, size: 20),
          label: Text(
            'Read full article',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () => UrlHelper.open(context, url),
        ),
      ),
    );
  }
}
