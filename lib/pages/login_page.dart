import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:http/http.dart' as http;
import 'package:school_ypi_new_two/Collection_styling/constants.dart';

import 'dart:convert';

import 'package:school_ypi_new_two/pages/dashboard_page.dart';



class LoginPage extends StatefulWidget {
  final String url;
  const LoginPage({super.key, required this.url});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nisnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String apiUrl = widget.url;
  bool isLoading = false;

  Future<void> _login() async {
    final nisn = _nisnController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true; // mulai loading
      });

      try {
        _showLoadingDialog(context);
        final url = Uri.parse(
          '${apiUrl}/auth',
        ); // Ganti dengan IP yang sesuai jika di emulator
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'username': nisn, 'password': password}),
        );

        Navigator.of(context).pop();
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          final token = data['access_token'];
          final user = data['user'];
          final username = user['username'];
          final nama = user['nama'];
          final uuid = user['uuid']; // bisa jadi penentu role juga

          // Simpan token dan data user

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(
                url: apiUrl,
                token: token,
                nama: nama,
                username: username,
                uuid: uuid,
              ),
            ),
          );
        } else if (response.statusCode == 401) {
          // Salah username/password
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username atau password salah')),
          );
        } else {
          final error = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error['message'] ?? 'Login gagal')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
      }
    }
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                'Please wait...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nisnController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingCollections.paddingMedium,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 0.01),
                Center(
                  child: Image.asset(
                    'assets/Logo.png',
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ),
                SizedBox(height: 00.1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('LOGIN', style: TextCollections.headingWelcomeColor),
                      const SizedBox(height: PaddingCollections.paddingSmall),
                      Text(
                        'Silahkan login menggunakan akun Anda',
                        style: TextCollections.bodyStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: PaddingCollections.paddingLarge),
                TextFormField(
                  controller: _nisnController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'USERNAME',
                    hintText: 'Masukkan USERNAME anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NISN tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: PaddingCollections.paddingMedium),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Masukkan password anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: PaddingCollections.paddingLarge),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const LupaPassword(),
                //         ),
                //       );
                //     },
                //     child: Text(
                //       'Lupa password?',
                //       style: TextCollections.loginstyle,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 190),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ButtonCollections.elevatedButtonStyle,
                    onPressed: () {
                      _login();
                    },
                    child: const Text(
                      'Masuk Sekarang',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: PaddingCollections.paddingMedium),

                // Center(
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => RegisterPage(url: apiUrl),
                //         ),
                //       );
                //     },
                //     child: RichText(
                //       text: const TextSpan(
                //         style: TextStyle(color: Colors.black, fontSize: 14),
                //         children: [
                //           TextSpan(text: 'Belum punya akun? '),
                //           TextSpan(
                //             text: 'Daftar sekarang',
                //             style: TextStyle(
                //               color: ColorCollections.primaryColor,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
