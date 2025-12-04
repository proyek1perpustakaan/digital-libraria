import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reservasi.dart';

class ReservasiService {
  static const String baseUrl =
      "https://692fb94d778bbf9e006e433e.mockapi.io/digilib";

  // Ambil semua data reservasi dari server
  Future<List<Reservasi>> getReservasi() async {
    final response = await http.get(Uri.parse("$baseUrl/reservasi"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Reservasi.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data reservasi");
    }
  }

  // Tambah reservasi (POST)
  Future<Reservasi> tambahReservasi(Reservasi r) async {
    final response = await http.post(
      Uri.parse("$baseUrl/reservasi"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(r.toJson()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Reservasi.fromJson(data);
    } else {
      throw Exception("Gagal menambahkan reservasi");
    }
  }

  // Update reservasi (PUT)
  Future<void> updateReservasi(String id, Reservasi r) async {
    final response = await http.put(
      Uri.parse("$baseUrl/reservasi/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(r.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal mengubah reservasi");
    }
  }

  // Hapus reservasi (DELETE)
  Future<void> hapusReservasi(String id) async {
    final response =
        await http.delete(Uri.parse("$baseUrl/reservasi/$id"));

    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus reservasi");
    }
  }
}
