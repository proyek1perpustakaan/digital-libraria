class Reservasi {
  final String kode;
  final String judul;
  final String tanggal;

  Reservasi({
    required this.kode,
    required this.judul,
    required this.tanggal,
  });

  Map<String, dynamic> toJson() => {
        "kode": kode,
        "judul": judul,
        "tanggal": tanggal,
      };

  factory Reservasi.fromJson(Map<String, dynamic> json) {
    return Reservasi(
      kode: json["kode"] ?? '',
      judul: json["judul"] ?? '',
      tanggal: json["tanggal"] ?? '',
    );
  }
}
