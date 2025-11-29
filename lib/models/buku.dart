class Buku {
  final String kode;
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

    return Buku(
      // Google Books ID (fallback dari properti paling aman)
      kode: json['id']?.toString() ?? '-',

      // Judul
      judul: volume['title'] ?? '-',

      // Authors → dijadikan string
      penulis: (volume['authors'] != null)
          ? (volume['authors'] as List).join(', ')
          : 'Tidak diketahui',

      // Penerbit
      penerbit: volume['publisher'] ?? 'Tidak diketahui',

      // Sinopsis (description)
      sinopsis: volume['description'] ?? 'Tidak ada sinopsis.',

      // Cover image (thumbnail)
      cover: volume['imageLinks'] != null
          ? (volume['imageLinks']['thumbnail'] ?? '')
          : '',
    );
  }
}
