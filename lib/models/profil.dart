class Profil {
  final String id;
  final String fullName;
  final String institution;
  final String nim;
  final String studyProgram;
  final String email;
  final String phone;

  Profil({
    required this.id,
    required this.fullName,
    required this.institution,
    required this.nim,
    required this.studyProgram,
    required this.email,
    required this.phone,
  });

  factory Profil.fromMap(Map<String, dynamic> map) {
    return Profil(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      institution: map['institution'] ?? '',
      nim: map['nim'] ?? '',
      studyProgram: map['study_program'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
