import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservasi_provider.dart';
import '../models/reservasi.dart';
import '../themes/palette.dart';
import 'package:digital_libraria/providers/theme.provider.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1F2A1F) 
          : const Color(0xFFDDF0D5), // light green
      bottomNavigationBar: _bottomNav(context, isDark),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Daftar Reservasi",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark
            ? const Color(0xFF1F2A1F)
            : const Color(0xFFDDF0D5),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      body: Consumer<ReservasiProvider>(
        builder: (context, provider, _) {

          final List<Reservasi> reservasi = provider.reservasiList;

          if (reservasi.isEmpty) {
            return Center(
              child: Text(
                "Belum ada reservasi",
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reservasi.length,
            itemBuilder: (context, index) {
              final item = reservasi[index];
              final tgl = DateTime.parse(item.tanggal);

              return Dismissible(
                key: ValueKey(item.kode),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white, size: 28),
                ),
                onDismissed: (_) {
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
                  color:
                      isDark ? const Color(0xFF2C3A2C) : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color:
                          isDark ? Colors.greenAccent : Colors.green,
                      size: 35,
                    ),
                    title: Text(
                      "Reservasi Berhasil",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kode Buku: ${item.kode}",
                          style: TextStyle(
                            color:
                                isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Text(
                          "Judul: ${item.judul}",
                          style: TextStyle(
                            color:
                                isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        Text(
                          "Tanggal: ${tgl.day}-${tgl.month}-${tgl.year}",
                          style: TextStyle(
                            color:
                                isDark ? Colors.white70 : Colors.black87,
                          ),
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

  Widget _bottomNav(BuildContext context, bool isDark) {
    return BottomNavigationBar(
      backgroundColor:
          isDark ? Palette.backgroundDark : Palette.backgroundLight,
      selectedItemColor: Palette.primaryGreen,
      unselectedItemColor:
          (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.5),
      currentIndex: 1,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
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
