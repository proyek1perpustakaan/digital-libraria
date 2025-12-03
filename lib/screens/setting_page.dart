import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/providers/theme.provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFDDF0D5),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Pengaturan"),
        centerTitle: true,
        backgroundColor: const Color(0xFFDDF0D5),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: _bottomNav(context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 2,
            child: SwitchListTile(
              title: const Text("Mode Gelap"),
              subtitle: Text(
                themeProvider.isDarkMode
                    ? "Tema gelap aktif"
                    : "Tema terang aktif",
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
              secondary: const Icon(Icons.dark_mode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6BBE72),
      unselectedItemColor: Colors.black45,
      
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
