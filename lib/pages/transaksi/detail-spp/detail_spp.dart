import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DetailSpp extends StatefulWidget {
  final String uuid;
  final String url;

  const DetailSpp({super.key, required this.url, required this.uuid});

  @override
  State<DetailSpp> createState() => _DetailSppState();
}

class _DetailSppState extends State<DetailSpp> {
  bool isLoading = false;
  Map<String, dynamic>? detailData;

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

    final url = Uri.parse('${widget.url}/detail-tagihan-spp');

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
          detailData = data;
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
      builder: (_) => const AlertDialog(
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
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : detailData == null
          ? const Center(child: Text('Data tidak ditemukan.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Transaksi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem('UUID', detailData!['uuid'] ?? '-'),
                    _buildDetailItem(
                      'Status',
                      detailData!['status'] == 'Lunas'
                          ? '✅ Lunas'
                          : '❌ Belum Lunas',
                      isBold: true,
                    ),
                    _buildDetailItem('Kondisi', detailData!['kondisi'] ?? '-'),
                    _buildDetailItem(
                      'Nominal',
                      'Rp. ${detailData!['nominal'] ?? '0'}',
                    ),
                    _buildDetailItem(
                      'Sisa Pembayaran',
                      'Rp. ${detailData!['sisa'] ?? '0'}',
                    ),
                    _buildDetailItem('Tanggal', detailData!['created_at']),
                  ],
                ),
              ),
            ),
    );
  }
}
