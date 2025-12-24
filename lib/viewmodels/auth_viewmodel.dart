import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = Supabase.instance.client.auth;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> register(
    String email,
    String password,
    String name,
  ) async {
    _loading = true;
    notifyListeners();

    await _auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _loading = true;
    notifyListeners();

    await _auth.signInWithPassword(
      email: email,
      password: password,
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  bool get isLoggedIn =>
      _auth.currentSession != null;
}