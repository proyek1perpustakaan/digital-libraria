import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/models/buku.dart';
import 'package:digital_libraria/models/reservasi.dart';
import 'package:digital_libraria/providers/reservasi_provider.dart';
import 'package:digital_libraria/themes/palette.dart';

class DetailBukuPage extends StatelessWidget {
  final Buku buku;
  const DetailBukuPage({super.key, required this.buku});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? Palette.greenDark : Colors.white,
      appBar: AppBar(
        title: Text(
          buku.judul,
          style: TextStyle(
            color: isDark ? Palette.textDark : Palette.textLight,
          ),
        ),
        backgroundColor:
            isDark ? Palette.greenDark : Colors.white,
        foregroundColor: isDark ? Palette.textDark : Palette.textLight,
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

            Text(
              "Kode Buku: ${buku.kode}",
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              buku.judul,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "Penulis: ${buku.penulis}",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              "Penerbit: ${buku.penerbit}",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Sinopsis",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              buku.sinopsis,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 18,
                  ),
                  backgroundColor: isDark
                      ? Palette.greenGradientDark
                      : Palette.greenGradientLight,
                  foregroundColor:
                      isDark ? Palette.textDark : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _tampilkanKonfirmasi(context);
                },
                child: const Text(
                  "Reservasi Buku",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tampilkanKonfirmasi(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:
            isDark ? Palette.cardDark : Palette.cardLight,
        title: Text(
          "Konfirmasi Reservasi",
          style: TextStyle(
            color: isDark ? Palette.textDark : Palette.textLight,
          ),
        ),
        content: Text(
          "Apakah Anda yakin ingin melakukan reservasi untuk buku \"${buku.judul}\"?",
          style: TextStyle(
            color: isDark ? Palette.textDark : Palette.textLight,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Tidak",
              style: TextStyle(
                color: isDark ? Palette.textDark : Colors.black,
              ),
            ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDark ? Palette.greenGradientDark : Palette.greenGradientLight,
              foregroundColor:
                  isDark ? Palette.textDark : Colors.black,
            ),
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }
}
