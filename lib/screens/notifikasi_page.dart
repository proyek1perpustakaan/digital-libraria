import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservasi_provider.dart';
import '../models/reservasi.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDF0D5),
      bottomNavigationBar: _bottomNav(context),
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Daftar Reservasi"),
        centerTitle: true,
        backgroundColor: Color(0xFFDDF0D5),
        automaticallyImplyLeading: false, 
      ),
      body: Consumer<ReservasiProvider>(
        builder: (context, provider, _) {
          final List<Reservasi> reservasi = provider.reservasiList;
          if (reservasi.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada reservasi",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reservasi.length,
            itemBuilder: (context, index) {
              final item = reservasi[index];

              return Dismissible(
                key: ValueKey(item.kode),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white, size: 28),
                ),
                onDismissed: (direction) {
                  provider.hapusReservasi(item.kode);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Reservasi dihapus")),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.check_circle,
                        color: Colors.green, size: 35),
                    title: const Text(
                      "Reservasi Berhasil",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Judul: ${item.judul}"),
                        Text("Kode Buku: ${item.kode}"),
                        Text(
                          "Tanggal: "
                          "${DateTime.parse(item.tanggal).day}-"
                          "${DateTime.parse(item.tanggal).month}-"
                          "${DateTime.parse(item.tanggal).year}",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6BBE72),
      unselectedItemColor: Colors.black45,

      currentIndex: 1, 
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
        } else if (index == 1) {
          // tetap
        } else if (index == 2) {
          Navigator.pushNamed(context, '/setting');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifikasi"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
      ],
    );
  }
}
