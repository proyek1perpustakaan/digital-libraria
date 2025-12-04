import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/providers/reservasi_provider.dart';
import 'package:digital_libraria/providers/theme.provider.dart';
import 'package:digital_libraria/screens/setting_page.dart';
import 'package:digital_libraria/screens/splash_screen.dart';
import 'package:digital_libraria/screens/home_page.dart';
import 'package:digital_libraria/screens/search_page.dart';
import 'package:digital_libraria/screens/notifikasi_page.dart';
import 'package:digital_libraria/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final reservasiProvider = ReservasiProvider();
  await reservasiProvider.loadReservasi();

  final themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => reservasiProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Libraria',
      themeMode: themeProvider.themeMode,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Routing
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/notifikasi': (context) => const NotifikasiPage(),
        '/setting': (context) => const SettingPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/search') {
          final query = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => SearchPage(query: query),
          );
        }
        return null;
      },
    );
  }
}
