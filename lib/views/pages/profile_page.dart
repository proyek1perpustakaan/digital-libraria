import 'package:flutter/material.dart';
import '../../themes/palette.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: BoxDecoration(
        color: isDark ? Palette.backgroundDark : Palette.backgroundLight,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _headerProfile(context),
            const SizedBox(height: 20),
            _profileInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/image/profil.png"),
        ),
        SizedBox(height: 12),
        Text(
          "Dhiva Franciscia",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          "Politeknik Negeri Indramayu",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _infoRow("NIM", "2405051"),
          _infoRow("Program Studi", "D4 Rekayasa Perangkat Lunak"),
          _infoRow("Email", "dhiva@gmail.com"),
          _infoRow("No. Telepon", "+62 812-3456-7890"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
