  import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_ypi_new_two/pages/transaksi/web_view_payment.dart';


class TagihanSpp extends StatefulWidget {
  final String bulan;
  final String url;
  final String uuid;
  const TagihanSpp({
    super.key,
    required this.bulan,
    required this.url,
    required this.uuid,
  });

  @override
  State<TagihanSpp> createState() => _TagihanSppState();
}

class _TagihanSppState extends State<TagihanSpp> {
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
  var data = '';
  var sisa = 0;

  Future<void> _search() async {
    try {
      final url = Uri.parse(
        '${widget.url}/cek-tagihan-spp',
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
          // 'periode': selectedPeriode,
          'kelas': selectedKelas,
          'bulan': widget.bulan,
        }),
      );

      if (response.statusCode == 200) {
        final apiData = jsonDecode(response.body);
        setState(() {
          data = apiData['status'] ?? '';
          sisa = apiData['sisa'] ?? 0;
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

  Future<String?> getSnapToken() async {
    final tokenUrl = Uri.parse('${widget.url}/api/payment-spp/${widget.uuid}');

    try {
      final response = await http.get(tokenUrl);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['snap_token'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendapatkan token pembayaran')),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saat mengambil token: $e')));
      return null;
    }
  }

  Future<void> _handlePayment(int amount) async {
    _showLoadingDialog(context);

    final response = await http.get(
      Uri.parse(
        '${widget.url}/payment-spp/${widget.uuid}/$amount/${selectedKelas}/${widget.bulan}',
      ),
      headers: {'Accept': 'application/json'},
    );

    Navigator.of(context).pop(); // Tutup loading

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final snapToken = json['snap_token'];

      if (snapToken != null) {
        final paymentUrl =
            'https://app.sandbox.midtrans.com/snap/v3/redirection/$snapToken';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPagePayment(url: paymentUrl),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendapatkan token pembayaran')),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
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
        'Hasil dummy: TagihanSpp ${widget.bulan}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TagihanSpp ${widget.bulan}'),
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
                child: Column(
                  children: [
                    if (data != 'Lunas')
                     Card(
                    color: const Color.fromARGB(255, 255, 253, 253),
                    child: ListTile(
                      leading: const Icon(Icons.sticky_note_2_outlined),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Spp Bulan ${widget.bulan} kelas $selectedKelas'),
                          Text(
                            data ?? '-',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        formatRupiah(sisa),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          TextEditingController _amountController =
                              TextEditingController(text: sisa.toString());

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Masukkan Nominal Pembayaran'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'cicilan dimulai dengan nominal 20.000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                     Text(
                                      'Target Biaya Maksimal 100.000',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      'Biaya default: ${formatRupiah(sisa)}\n\nIsi nominal khusus jika ingin bayar sebagian.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    TextField(
                                      controller: _amountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Contoh: 50000',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context); // tutup dialog
                                      int defaultAmount = 70000; // contoh default

                                      // ✅ Validasi minimal
                                      if (defaultAmount < 20000) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Minimal pembayaran SPP adalah Rp20.000')),
                                        );
                                        return;
                                      }
                                      // ✅ Validasi maksimal
                                      if (defaultAmount > 100000) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Maksimal pembayaran SPP adalah Rp100.000')),
                                        );
                                        return;
                                      }

                                      await _handlePayment(defaultAmount);
                                    },
                                    child: Text('Gunakan Default'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Navigator.pop(context); // tutup dialog
                                      int? customAmount = int.tryParse(_amountController.text);

                                      if (customAmount == null || customAmount <= 0) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Nominal tidak valid')),
                                        );
                                        return;
                                      }
                                      // ✅ Validasi minimal
                                      if (customAmount < 20000) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Minimal pembayaran SPP adalah Rp20.000')),
                                        );
                                        return;
                                      }
                                      // ✅ Validasi maksimal
                                      if (customAmount > 100000) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Maksimal pembayaran SPP adalah Rp100.000')),
                                        );
                                        return;
                                      }

                                      await _handlePayment(customAmount);
                                    },
                                    child: Text('Gunakan Nominal Ini'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: Text('Bayar Sekarang'),
                      ),
                    ),
                  )

                    else
                      Text('Tidak ada data tagihan'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
