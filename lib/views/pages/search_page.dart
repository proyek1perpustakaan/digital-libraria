import 'package:flutter/material.dart';
import 'package:digital_libraria/models/buku.dart';
import 'package:digital_libraria/services/buku_service.dart';
import 'package:digital_libraria/views/pages/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:digital_libraria/viewmodels/theme_viewmodel.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Buku> hasilPencarian = [];
  bool isLoading = true;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.query);
    _cariBuku();
  }

  Future<void> _cariBuku() async {
    setState(() => isLoading = true);
    try {
      hasilPencarian = await BukuService().searchBuku(searchController.text);
    } catch (e) {
      hasilPencarian = [];
      print("Error: $e");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1F2A1F) : const Color(0xFFDDF0D5),

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isDark ? const Color(0xFF1F2A1F) : const Color(0xFFDDF0D5),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/image/logo.png',
              height: 40,
              color: isDark ? Colors.white : null,
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // SEARCH BOX
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C3A2C) : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: searchController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Cari Buku",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onSubmitted: (_) => _cariBuku(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : hasilPencarian.isEmpty
                      ? Center(
                          child: Text(
                            "Buku tidak ditemukan",
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark ? Colors.white70 : Colors.black,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: hasilPencarian.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final buku = hasilPencarian[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailBukuPage(buku: buku),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF2C3A2C)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isDark
                                      ? [] 
                                      : [
                                          BoxShadow(
                                            color: Colors.black12
                                                .withOpacity(0.05),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        buku.cover,
                                        width: 60,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 60,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.white10
                                                  : Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.book,
                                              color: isDark
                                                  ? Colors.white54
                                                  : Colors.black54,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            buku.judul,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            buku.penulis,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: isDark
                                                  ? Colors.white70
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
