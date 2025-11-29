import 'package:digital_libraria/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Libraria',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/search') {
          final String query = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => SearchPage(query: query),
          );
        }
        return null;
      },
    );
  }
}
