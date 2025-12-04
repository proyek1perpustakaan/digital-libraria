import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/providers/theme.provider.dart';
import '../themes/palette.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1F2A1F) // DARK GREEN
          : const Color(0xFFDDF0D5), // LIGHT GREEN
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Pengaturan"),
        centerTitle: true,
        backgroundColor: isDark
            ? const Color(0xFF1F2A1F)
            : const Color(0xFFDDF0D5),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: _bottomNav(context, isDark),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 2,
            color: isDark ? const Color(0xFF2C3A2C) : Colors.white,
            child: SwitchListTile(
              title: Text(
                "Mode Gelap",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                isDark ? "Tema gelap aktif" : "Tema terang aktif",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
              secondary: Icon(
                Icons.dark_mode,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav(BuildContext context, bool isDark) {
    return BottomNavigationBar(
      backgroundColor:
          isDark ? Palette.backgroundDark : Palette.backgroundLight,
      selectedItemColor: Palette.primaryGreen,
      unselectedItemColor:
          (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.5),
      currentIndex: 2,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/notifikasi');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifikasi"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
      ],
    );
  }
}
