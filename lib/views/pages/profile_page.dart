import 'package:flutter/material.dart';
import '../../models/profil.dart';
import '../../themes/palette.dart';

class ProfilBottomSheet extends StatelessWidget {
  final Profil profile;
  final String authEmail; // tambahkan

  const ProfilBottomSheet({
    super.key,
    required this.profile,
    required this.authEmail,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: BoxDecoration(
        color: isDark ? Palette.backgroundDark : Palette.backgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _headerProfile(isDark),
            const SizedBox(height: 20),
            _profileInfo(isDark),
          ],
        ),
      ),
    );
  }

  Widget _headerProfile(bool isDark) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/image/profil.png"),
        ),
        const SizedBox(height: 12),
        Text(
          profile.fullName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Palette.textDark : Palette.textLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.institution,
          style: TextStyle(
            color: (isDark ? Palette.textDark : Palette.textLight).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _profileInfo(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _infoRow("NIM", profile.nim, isDark),
          _infoRow("Program Studi", profile.studyProgram, isDark),
          _infoRow("Email", profile.email.isNotEmpty ? profile.email : authEmail, isDark),
          _infoRow("No. Telepon", profile.phone, isDark),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Palette.textDark : Palette.textLight,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isDark ? Palette.textDark : Palette.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
