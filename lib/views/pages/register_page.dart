import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../themes/palette.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _nimController = TextEditingController();
  final _studyProgramController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _loading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      /// 1️⃣ SIGN UP AUTH
      final res = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = res.user;
      if (user == null) throw 'Gagal membuat akun';

      /// 2️⃣ INSERT KE TABLE PROFILES
      await Supabase.instance.client.from('profiles').insert({
        'id': user.id,
        'full_name': _nameController.text.trim(),
        'institution': _institutionController.text.trim(),
        'nim': _nimController.text.trim(),
        'study_program': _studyProgramController.text.trim(),
        'phone': _phoneController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrasi berhasil, silakan login'),
        ),
      );

      /// 3️⃣ REGISTER → LOGIN
      Navigator.pushReplacementNamed(context, '/login');
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? Palette.backgroundDark : Palette.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/image/splash.png", width: 110),
                const SizedBox(height: 20),

                Text(
                  "Pendaftaran",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Palette.textDark : Palette.textLight,
                  ),
                ),
                const SizedBox(height: 30),

                _inputField(
                  controller: _nameController,
                  label: "Nama Lengkap",
                  icon: Icons.person,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _institutionController,
                  label: "Nama Lembaga",
                  icon: Icons.account_balance,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _nimController,
                  label: "NIM",
                  icon: Icons.badge,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _studyProgramController,
                  label: "Program Studi",
                  icon: Icons.school,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _phoneController,
                  label: "Nomor Telepon",
                  icon: Icons.phone,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _emailController,
                  label: "Email",
                  icon: Icons.email,
                  isDark: isDark,
                  validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 14),

                _inputField(
                  controller: _passwordController,
                  label: "Password",
                  icon: Icons.lock,
                  obscure: !_isPasswordVisible,
                  isDark: isDark,
                  suffix: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                  validator: (v) =>
                      v!.length < 6 ? 'Minimal 6 karakter' : null,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Daftar", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: isDark ? Palette.cardDark : Palette.cardLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
