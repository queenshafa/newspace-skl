// TODO 6: Implementasi ThemeProvider
// 1. Install Riverpod: `flutter pub add flutter_riverpod`
// 2. Import 'package:flutter_riverpod/flutter_riverpod.dart';
// 3. Buat class ThemeNotifier extends Notifier<bool> (menyimpan state isDarkMode)
// 4. Implementasikan fungsi toggleTheme() untuk mengubah state dan menyimpannya di SharedPreferences
// 5. Buat themeProvider (NotifierProvider) untuk digunakan di UI

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';

final themeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());

//tema awal yang di baca di main.dart , sebelum app tampil(erjalan secara asyncronus / berbarengan)
//nilainya di override lewat 'ProviderScope.overrides'.

final initialThemeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

//mode tema yang aktif bisa terang atau gelap (default mengikuti sistem)
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(initialThemeProvider);

  //beralih ke kebalikan dari tema yang sedang tampil atau aktif
  void toggle(Brightness currentBrightness) {
    state = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    ref.read(themeStorageProvider).save(state);
  }
}

//TODO: deklarasikan sebuah notifier untuk memberitahukan pebrubahaan yang terjadi agar , aplikasi dapat mengetahui bahwa, akan ada perubahan yang terjadi pada tema

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
