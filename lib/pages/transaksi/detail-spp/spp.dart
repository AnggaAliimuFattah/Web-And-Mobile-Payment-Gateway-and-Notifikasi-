import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_ypi_new_two/pages/transaksi/detail-spp/detail_spp.dart';


class Spp extends StatefulWidget {
  final String bulan;
  final String url;
  final String uuid;

  const Spp({
    super.key,
    required this.bulan,
    required this.url,
    required this.uuid,
  });

  @override
  State<Spp> createState() => _SppState();
}

class _SppState extends State<Spp> {
  // String? selectedPeriode;
  String? selectedKelas;
  String? selectedStatus;

  List<String> hasilPencarian = [];

  // final List<String> periodeList = ['2023', '2024', '2025'];
  final List<String> kelasList = ['X', 'XI', 'XII'];
  final List<String> statusList = ['Cicilan', 'Lunas'];

  String thn = '2025';
  String kls = 'XI';
  String uid = '6b981240-cdaf-47c4-b9a8-9917f86804fb';
  List data = [];
  Future<void> _search() async {
    try {
      final url = Uri.parse(
        '${widget.url}/riwayat-tagihan-spp',
      ); // Ganti dengan IP yang sesuai jika di emulator
      _showLoadingDialog(context);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'uuid': widget.uuid,
          'kelas': selectedKelas,
          'bulan': widget.bulan,
        }),
      );

      if (response.statusCode == 200) {
        final apiData = jsonDecode(response.body);
        setState(() {
          data = apiData ?? '';
        });
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error['message'] ?? 'Login gagal')),
        );
      }
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
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

  void _cariData() {
    setState(() {
      hasilPencarian = [
        // 'Periode: $selectedPeriode',
        'Kelas: $selectedKelas',
        'Status: $selectedStatus',
        'Hasil dummy: SPP ${widget.bulan}',
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    // selectedPeriode = thn;
    // default nilai periode
    selectedKelas = kls; // default nilai kelas
    selectedStatus = 'Cicilan'; // default nilai status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _search();
    });
  }

  Widget _buildDropdown({
    required String label,
    required String? selectedValue,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue,
                hint: Text('Pilih $label'),
                icon: Icon(Icons.keyboard_arrow_down),
                items: items.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatRupiah(dynamic number) {
    if (number == null) return 'Rp 0';

    int nilai;
    if (number is String) {
      nilai = int.tryParse(number) ?? 0;
    } else if (number is int) {
      nilai = number;
    } else {
      return 'Rp 0';
    }

    String hasil = nilai.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    return 'Rp $hasil';
  }

  List<Widget> buildSppList() {
    List<Widget> widgets = [];

    if (data.isEmpty) {
      widgets.add(const Text('Tidak ada data SPP.'));
      return widgets;
    }

    for (int i = 0; i < data.length; i++) {
      widgets.add(
        Card(
          color: const Color.fromARGB(255, 255, 253, 253),
          child: ListTile(
            leading: const Icon(Icons.sticky_note_2_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailSpp(url: widget.url, uuid: data[i]['uuid']),
                ),
              );
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pendaftaran sekolah'),
                Text(
                  data[i]['status'] ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              formatRupiah(data[i]['nominal']),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.green,
              ),
            ),
            trailing: Text(
              formatRupiah(data[i]['sisa']),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPP ${widget.bulan}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // _buildDropdown(
                //   label: 'Periode',
                //   selectedValue: selectedPeriode,
                //   items: periodeList,
                //   onChanged: (value) {
                //     setState(() {
                //       selectedPeriode = value;
                //     });
                //     _search();
                //   },
                // ),
                SizedBox(width: 16),
                _buildDropdown(
                  label: 'Kelas',
                  selectedValue: selectedKelas,
                  items: kelasList,
                  onChanged: (value) {
                    setState(() {
                      selectedKelas = value;
                    });
                    _search();
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hasil:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: buildSppList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
