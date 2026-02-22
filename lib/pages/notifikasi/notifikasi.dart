import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notifikasi extends StatefulWidget {
  final uuid;
  final url;
  const Notifikasi({super.key, required this.uuid, required this.url});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  bool isLoading = false;
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Future<void> fetchData() async {//  ngambil data
    setState(() => isLoading = true);
    _showLoadingDialog(context);
    final url = Uri.parse('${widget.url}/activity-siswa');

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
        // Misalnya data berbentuk list, sesuaikan kalau beda
        setState(() {
          dataList = data;
        });
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

  Widget _buildInfoChip(String label, String value, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.15),
      label: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(color: color.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dataList.isEmpty
          ? const Center(child: Text('Tidak ada data'))
          : ListView.builder(
              itemCount: dataList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final item = dataList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UUID: ${item['uuid']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildInfoChip(
                              'Status',
                              item['status'],
                              Colors.green,
                            ),
                            _buildInfoChip(
                              'Kondisi',
                              item['kondisi'],
                              Colors.orange,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Text(
                          'Nominal: Rp ${item['nominal'].toString()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
