import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/models/buku.dart';
import 'package:digital_libraria/models/reservasi.dart';
import 'package:digital_libraria/providers/reservasi_provider.dart';

class DetailBukuPage extends StatelessWidget {
  final Buku buku;
  const DetailBukuPage({super.key, required this.buku});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(buku.judul),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  buku.cover,
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 150,
                    height: 220,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.book, size: 50),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text("Kode Buku: ${buku.kode}",
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),

            Text(buku.judul,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text("Penulis: ${buku.penulis}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),

            Text("Penerbit: ${buku.penerbit}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            const Text("Sinopsis",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text(
              buku.sinopsis,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 30),
            
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 18),
                  backgroundColor: Color(0xFFDDF0D5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  _tampilkanKonfirmasi(context);
                },
                child: const Text(
                  "Reservasi Buku",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tampilkanKonfirmasi(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Reservasi"),
        content: Text(
            "Apakah Anda yakin ingin melakukan reservasi untuk buku \"${buku.judul}\"?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              final provider =
                  Provider.of<ReservasiProvider>(context, listen: false);

              final reservasi = Reservasi(
                kode: buku.kode,
                judul: buku.judul,
                tanggal: DateTime.now().toIso8601String(),
              );
              await provider.tambahReservasi(reservasi);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Reservasi berhasil!")),
              );
              Navigator.pushNamed(context, '/notifikasi');
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }
}
