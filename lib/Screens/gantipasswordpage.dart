import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile_gmf/services/api_connect.dart';

class GantiPassword extends StatefulWidget {
  const GantiPassword({super.key});

  @override
  State<GantiPassword> createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  bool obscurePassword = true;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _gantiPassword() async {
  String newPassword = newPasswordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (newPassword.isEmpty || confirmPassword.isEmpty) {
    _showSnackBar('Semua field harus diisi');
    return;
  }

  if (newPassword != confirmPassword) {
    _showSnackBar('Password baru dan konfirmasi password tidak cocok');
    return;
  }

  // Ambil token dan email dari SharedPreferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  String? email = sharedPreferences.getString('email'); // Ambil email yang disimpan
  print('saya login menggunakan email : $email');

  if (token == null || email == null) {
    _showSnackBar('Anda harus login terlebih dahulu');
    return;
  }

  // Membuat request untuk mengganti password
  try {
    final response = await http.post(
      Uri.parse(ApiConnect.updatePassword),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Sertakan token di header
      },
      body: json.encode({
        'email': email, // Kirimkan email yang disimpan
        'password': newPassword, // Kirimkan password baru
      }),
    );

    if (response.statusCode == 200) {
      _showSnackBar('Password berhasil diganti');
    } else {
      final responseData = json.decode(response.body);
      _showSnackBar(responseData['message'] ?? 'Terjadi kesalahan');
    }
  } catch (e) {
    _showSnackBar('Gagal menghubungi server');
  }
}


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ganti Password'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: oldPasswordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Password Lama',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Password baru',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
                hintText: 'Konfirmasi Password Baru',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _gantiPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Ganti Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
