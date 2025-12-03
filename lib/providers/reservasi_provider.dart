import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reservasi.dart';

class ReservasiProvider extends ChangeNotifier {
  List<Reservasi> _reservasiList = [];

  List<Reservasi> get reservasiList => _reservasiList;

  ReservasiProvider() {
    loadReservasi();   
  }

  Future<void> loadReservasi() async {
    await _loadFromPrefs();
  }

  Future<void> tambahReservasi(Reservasi r) async {
    _reservasiList.add(r);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        _reservasiList.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList("reservasi_list", jsonList);
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("reservasi_list");
    if (data != null) {
      _reservasiList =
          data.map((e) => Reservasi.fromJson(jsonDecode(e))).toList();
    }
    notifyListeners();
  }

  Future<void> hapusReservasi(String id) async {
    _reservasiList.removeWhere((e) => e.kode == id);
    await _saveToPrefs();
    notifyListeners();
  }

}
