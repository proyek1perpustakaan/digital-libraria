import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class BukuService {
  Future<List<Buku>> searchBuku(String query) async {
    final url = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=40");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["items"] == null) return [];

      final List items = data["items"];

      return items.map<Buku>((item) {
        final json = item;
        return Buku.fromJson(json);
      }).toList();
    }

    throw Exception("Gagal mengambil data buku");
  }
}
