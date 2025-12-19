import 'package:digital_libraria/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../../models/buku.dart';
import '../../services/buku_service.dart';
import '../../themes/palette.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final BukuService bukuService = BukuService();

  List<Buku> _books = [];
  bool _isLoading = false;

  Future<void> searchBuku(String query) async {
    setState(() => _isLoading = true);
    try {
      _books = await bukuService.searchBuku(query);
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? Palette.backgroundDark : Palette.backgroundLight,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerGradient(
                  context,
                  isDark
                      ? Palette.greenGradientDark
                      : Palette.greenGradientLight,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildAbout(context),
                ),
                const SizedBox(height: 30),
                _infoSection(
                  context,
                  isDark ? Palette.greenDark : Palette.greenLight,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottomNav(context),
          ),
        ],
      ),
    );
  }

  Widget _headerGradient(BuildContext context, Color adaptiveGradientGreen) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDark ? Palette.backgroundDark : Palette.backgroundLight,
            adaptiveGradientGreen
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 30),
          Text(
            "Reservasi Buku Online",
            style: TextStyle(
              fontSize: size.width * 0.040,
              color: (isDark ? Palette.textDark : Palette.textLight)
                  .withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Pinjam Buku,\nBaca Dunia\nBaru",
            style: TextStyle(
              fontSize: size.width * 0.090,
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: isDark ? Palette.textDark : Palette.textLight,
            ),
          ),
          const SizedBox(height: 25),
          _buildSearchBar(context),
        ],
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/image/logo.png',
          height: 35,
          color: isDark ? Colors.white : null,
        ),

        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              builder: (_) => const ProfileBottomSheet()
            );
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Dhiva Franciscia",
                    style: TextStyle(
                      fontSize: size.width * 0.030,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Palette.textDark : Palette.textLight,
                    ),
                  ),
                  Text(
                    "Politeknik Negeri Indramayu",
                    style: TextStyle(
                      fontSize: size.width * 0.030,
                      color: (isDark ? Palette.textDark : Palette.textLight)
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/image/profil.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: isDark ? Palette.cardDark : Palette.cardLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: isDark ? Palette.textDark : Palette.textLight),
        decoration: InputDecoration(
          hintText: "Cari Buku",
          hintStyle: TextStyle(
            color:
                (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.4),
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search,
              color: isDark ? Palette.textDark : Palette.textLight),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchPage(query: query)),
            );
          }
        },
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            "assets/image/bg_buku.png",
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apa itu DigiLib?",
                style: TextStyle(
                  fontSize: size.width * 0.060,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Palette.textDark : Palette.textLight,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Digilib merupakan singkatan dari Digital Libraria, "
                "sebuah website yang dapat melakukan reservasi buku "
                "secara online. Oleh karena itu, aplikasi ini dapat "
                "mempermudah pemustaka yang ingin meminjam buku.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: (isDark ? Palette.textDark : Palette.textLight)
                      .withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoSection(BuildContext context, Color adaptiveGreen) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: adaptiveGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jam Operasional",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Palette.textDark : Palette.textLight,
            ),
          ),
          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Senin–Jumat",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Palette.textDark : Palette.textLight,
                  ),
                ),
                TextSpan(
                  text: " : 08.00 – 15.00 WIB",
                  style: TextStyle(
                      color: isDark ? Palette.textDark : Palette.textLight),
                ),
              ],
            ),
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Cuti Bersama & Libur Nasional ",
                  style: TextStyle(
                      color: isDark ? Palette.textDark : Palette.textLight),
                ),
                TextSpan(
                  text: "Tutup",
                  style: TextStyle(
                    color: isDark ? Palette.textDark : Palette.textLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          Divider(
            color:
                (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.5),
          ),
          const SizedBox(height: 20),

          Text(
            "Kontak Kami",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Palette.textDark : Palette.textLight,
            ),
          ),

          const SizedBox(height: 10),

          Text("No. Telepon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Palette.textDark : Palette.textLight,
              )),
          Text("+62 831-2314-5678",
              style:
                  TextStyle(color: isDark ? Palette.textDark : Palette.textLight)),
          const SizedBox(height: 12),

          Text("Email",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Palette.textDark : Palette.textLight,
              )),
          Text("proyek1perpustakaan@gmail.com",
              style:
                  TextStyle(color: isDark ? Palette.textDark : Palette.textLight)),
          const SizedBox(height: 12),

          Text("Alamat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Palette.textDark : Palette.textLight,
              )),
          Text("Jalan Raya Lohbener Lama No. 08 Lohbener",
              style:
                  TextStyle(color: isDark ? Palette.textDark : Palette.textLight)),
        ],
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      backgroundColor:
          isDark ? Palette.backgroundDark : Palette.backgroundLight,
      selectedItemColor: Palette.primaryGreen,
      unselectedItemColor:
          (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.5),
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.pushNamed(context, '/reservasi');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/setting');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Reservasi"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
      ],
    );
  }

}
