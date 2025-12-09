import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reservasi.dart';

class ReservasiService {
  final supabase = Supabase.instance.client;

  Future<List<Reservasi>> getReservasi() async {
    final response = await supabase
        .from('reservasi')
        .select();

    return (response as List)
        .map((e) => Reservasi.fromJson(e))
        .toList();
  }

  Future<Reservasi> tambahReservasi(Reservasi r) async {
    try {
      final response = await supabase
          .from('reservasi')
          .insert(r.toJson())
          .select()
          .maybeSingle();

      if (response == null) {
        throw Exception("Insert gagal: Supabase tidak mengembalikan data.");
      }

      return Reservasi.fromJson(response);
    } catch (e) {
      print("SUPABASE ERROR: $e");
      throw Exception("Gagal insert ke Supabase: $e");
    }
  }

  Future<void> hapusReservasi(String kode) async {
    await supabase
        .from('reservasi')
        .delete()
        .eq('kode', kode);
  }
}
