class Buku {
  final String kode; // ISBN dipakai sebagai kode buku
  final String judul;
  final String penulis;
  final String penerbit;
  final String sinopsis;
  final String cover;

  Buku({
    required this.kode,
    required this.judul,
    required this.penulis,
    required this.penerbit,
    required this.sinopsis,
    required this.cover,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    final volume = json['volumeInfo'] ?? {};

    String? isbn10;
    String? isbn13;

    if (volume['industryIdentifiers'] != null) {
      for (var id in volume['industryIdentifiers']) {
        if (id['type'] == 'ISBN_10') isbn10 = id['identifier'];
        if (id['type'] == 'ISBN_13') isbn13 = id['identifier'];
      }
    }
    
    final kodeBuku = isbn13 ?? isbn10 ?? json['id']?.toString() ?? '-';

    return Buku(
      kode: kodeBuku, // gunakan ISBN di sini
      judul: volume['title'] ?? '-',
      penulis: (volume['authors'] != null)
          ? (volume['authors'] as List).join(', ')
          : 'Tidak diketahui',
      penerbit: volume['publisher'] ?? 'Tidak diketahui',
      sinopsis: volume['description'] ?? 'Tidak ada sinopsis.',
      cover: volume['imageLinks'] != null
          ? (volume['imageLinks']['thumbnail'] ?? '')
          : '',
    );
  }
}
