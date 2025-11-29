import 'package:flutter/material.dart';
import '../models/buku.dart';
import '../services/buku_service.dart';
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerGradient(size),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildAbout(size),
                ),
                const SizedBox(height: 30),
                _infoSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _headerGradient(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFDDF0D5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(size),
          const SizedBox(height: 30),
          Text(
            "Reservasi Buku Online",
            style: TextStyle(
              fontSize: size.width * 0.040,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Pinjam Buku,\nBaca Dunia\nBaru",
            style: TextStyle(
              fontSize: size.width * 0.090,
              height: 1.2,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 25),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/image/logo.png", height: 35),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Dhiva Franciscia",
                  style: TextStyle(
                    fontSize: size.width * 0.030,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Politeknik Negeri Indramayu",
                  style: TextStyle(
                    fontSize: size.width * 0.030,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius:20,
              backgroundImage: AssetImage("assets/image/profil.png"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center, 
        decoration: const InputDecoration(
          hintText: "Cari Buku",
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
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

  Widget _buildAbout(Size size) {
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
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Digilib merupakan singkatan dari Digital Libraria, "
                "sebuah website yang dapat melakukan reservasi buku "
                "secara online. Oleh karena itu, aplikasi ini dapat "
                "mempermudah pemustaka yang ingin meminjam buku.",
                style: TextStyle(fontSize: 14, height: 1.45),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: const Color(0xFFDFEBD3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Jam Operasional",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Senin–Jumat",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: " : 08.00 – 15.00 WIB",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Cuti Bersama & Libur Nasional ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Tutup",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          const Divider(color: Colors.black54),
          const SizedBox(height: 20),

          const Text(
            "Kontak Kami",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          const Text("No. Telepon", 
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          const Text("+62 831-2314-5678"),
          const SizedBox(height: 12),

          const Text("Email",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          const Text("proyek1perpustakaan@gmail.com"),
          const SizedBox(height: 12),

          const Text("Alamat",
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          const Text("Jalan Raya Lohbener Lama No. 08 Lohbener"),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    return Container(
      color: Colors.white,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6BBE72),
        unselectedItemColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifikasi"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
        ],
      ),
    );
  }
}
