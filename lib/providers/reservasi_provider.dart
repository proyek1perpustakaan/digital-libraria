import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reservasi.dart';
import '../services/reservasi_service.dart';

class ReservasiProvider extends ChangeNotifier {
  final ReservasiService service = ReservasiService();

  List<Reservasi> _reservasiList = [];
  List<Reservasi> get reservasiList => _reservasiList;

  ReservasiProvider() {
    loadReservasi();
  }

  Future<void> loadReservasi() async {
    try {
      final dataRemote = await service.getReservasi();
      _reservasiList = dataRemote;
      await _saveToPrefs();
    } catch (e) {
      await _loadFromPrefs();
      print("LOAD LOCAL: $e");
    }
    notifyListeners();
  }

  Future<void> tambahReservasi(Reservasi r) async {
    try {
      final created = await service.tambahReservasi(r);
      _reservasiList.add(created);
      await _saveToPrefs();
      notifyListeners();
    } catch (e) {
      print("ERROR PROVIDER: $e");
      rethrow;
    }
  }

  Future<void> hapusReservasi(String kode) async {
    try {
      await service.hapusReservasi(kode);
      _reservasiList.removeWhere((e) => e.kode == kode);
      await _saveToPrefs();
      notifyListeners();
    } catch (e) {
      print("ERROR DELETE: $e");
    }
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
  }
}
