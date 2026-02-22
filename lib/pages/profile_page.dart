import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final uuid;
  final url;
  const ProfilePage({Key? key, required this.uuid, required this.url})
    : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  String nama = '';
  String nis = '';
  String kelas = '';
  String alamat = '';
  String jenisKelamin = '';
  String agama = '';
  String noTelp = '';
  String tempatLahir = '';
  String tanggalLahir = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDataSiswa();
    });
  }

  Future<void> fetchDataSiswa() async {
    setState(() => isLoading = true);
    _showLoadingDialog(context);
    final url = Uri.parse('${widget.url}/data-siswa');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'uuid': widget.uuid}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nama = data['nama'] ?? '';
          nis = data['nis'] ?? '';
          kelas = data['kelas'] ?? '';
          alamat = data['alamat'] ?? '';
          jenisKelamin = data['jenis_kelamin'] ?? '';
          agama = data['agama'] ?? '';
          noTelp = data['no_telp'] ?? '';
          tempatLahir = data['tempat_lahir'] ?? '';
          tanggalLahir = data['tanggal_lahir'] ?? '';
        });

        // Lakukan sesuatu, misalnya setState untuk menyimpan nilai
      } else {
        print('Gagal mendapatkan data. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
    setState(() => isLoading = false);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    if (!isLoading) return;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfoTile(Icons.person, 'Nama', nama),
            _buildInfoTile(Icons.badge, 'NIS', nis),
            _buildInfoTile(Icons.class_, 'Kelas', kelas),
            _buildInfoTile(Icons.home, 'Alamat', alamat),
            _buildInfoTile(Icons.wc, 'Jenis Kelamin', jenisKelamin),
            _buildInfoTile(Icons.accessibility_new, 'Agama', agama),
            _buildInfoTile(Icons.phone, 'No. Telepon', noTelp),
            _buildInfoTile(Icons.location_city, 'Tempat Lahir', tempatLahir),
            _buildInfoTile(Icons.cake, 'Tanggal Lahir', tanggalLahir),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
    );
  }
}
