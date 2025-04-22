import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_helperr/utils/theme_provider.dart';

/// A switch widget that toggles between dark and light theme modes
class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
      value: themeProvider.isDarkMode,
      onChanged: (newValue) {
        // استخدم القيمة الجديدة مباشرة
        themeProvider.setThemeMode(newValue ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}