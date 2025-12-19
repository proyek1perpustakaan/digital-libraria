import 'package:digital_libraria/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:digital_libraria/viewmodels/reservasi_viewmodel.dart';
import 'package:digital_libraria/viewmodels/theme_viewmodel.dart';
import 'package:digital_libraria/views/pages/home_page.dart';
import 'package:digital_libraria/views/pages/reservasi_page.dart';
import 'package:digital_libraria/views/pages/search_page.dart';
import 'package:digital_libraria/views/pages/setting_page.dart';
import 'package:digital_libraria/views/pages/splash_screen.dart';
import 'package:digital_libraria/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tgdnktpbwwpaneoohdow.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnZG5rdHBid3dwYW5lb29oZG93Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUyMTA5NTYsImV4cCI6MjA4MDc4Njk1Nn0.cXlZy3Ai6smmF9oXg-4zLyKPgqM1AAdFniNmMXof6hI',
  );

  runApp(const AppStarter());
}

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()
        ),
        ChangeNotifierProvider(
          create: (_) => ReservasiProvider()..loadReservasi(), 
        ),
      ],
      child: const MyApp(),
    );
  }
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/reservasi': (context) => const NotifikasiPage(),
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
