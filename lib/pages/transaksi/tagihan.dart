import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_ypi_new_two/pages/transaksi/detail-spp/tagihan_spp.dart';
import 'dart:convert';

import 'package:school_ypi_new_two/pages/transaksi/web_view_payment.dart';


class Tagihan extends StatefulWidget {
  final String url;
  final String uuid;
  const Tagihan({super.key, required this.url, required this.uuid});

  @override
  State<Tagihan> createState() => _TagihanState();
}

class _TagihanState extends State<Tagihan> with SingleTickerProviderStateMixin {
  var data = '';
  var sisa = 0;

  var data2 = '';
  var sisa2 = 0;

  var data3 = '';
  var sisa3 = 0;

  final List<String> kelasList = ['X', 'XI', 'XII'];

  String? selectedKelasUts;
  String? selectedKelasUas;

  late TabController _tabController;

  bool isLoading = false;

  final List<String> bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  late final List<String> urutanBulan;

  @override
  void initState() {
    super.initState();

    urutanBulan = [
      ...bulan.sublist(5), // Juni - Desember
      ...bulan.sublist(0, 5), // Januari - Mei
    ];

    selectedKelasUts = kelasList[0];
    selectedKelasUas = kelasList[0];

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Load pendaftaran di awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPendaftaran();
    });
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      if (_tabController.index == 2) {
        // Tab UTS
        if (data2.isEmpty) {
          fetchUts();
        }
      } else if (_tabController.index == 3) {
        // Tab UAS
        if (data3.isEmpty) {
          fetchUas();
        }
      }
    }
  }

  Future<void> fetchPendaftaran() async {
    setState(() => isLoading = true);
    _showLoadingDialog(context);

    try {
      final uris = Uri.parse(
        '${widget.url}/cek-tagihan-pendaftaran/${widget.uuid}',
      );
      final response = await http.get(uris);

      if (response.statusCode == 200) {
        final apiData = json.decode(response.body);
        setState(() {
          data = apiData['status'] ?? '';
          sisa = apiData['sisa'] ?? 0;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      setState(() => isLoading = false);
      if (mounted) Navigator.of(context).pop(); // tutup dialog
    }
  }

  Future<void> fetchUts() async {
    setState(() => isLoading = true);
    _showLoadingDialog(context);

    try {
      final url = Uri.parse('${widget.url}/cek-tagihan-uts');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'uuid': widget.uuid, 'kelas': selectedKelasUts}),
      );

      if (response.statusCode == 200) {
        final apiData2 = jsonDecode(response.body);
        print(apiData2);
        setState(() {
          data2 = apiData2['status'] ?? '';
          sisa2 = apiData2['sisa'] ?? 0;
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
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      setState(() => isLoading = false);
      if (mounted) Navigator.of(context).pop();
    }
  }

  Future<void> fetchUas() async {
    setState(() => isLoading = true);
    _showLoadingDialog(context);

    try {
      final url = Uri.parse('${widget.url}/cek-tagihan-uas');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'uuid': widget.uuid, 'kelas': selectedKelasUas}),
      );

      if (response.statusCode == 200) {
        final apiData3 = jsonDecode(response.body);
        setState(() {
          data3 = apiData3['status'] ?? '';
          sisa3 = apiData3['sisa'] ?? 0;
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
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      setState(() => isLoading = false);
      if (mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _handlePayment(int amount) async {// fungsi untuk menangani pembayaran
    _showLoadingDialog(context);

    final response = await http.get(
      Uri.parse('${widget.url}/payment-pendaftaran/${widget.uuid}/$amount'),
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

  Future<void> _handlePayment2(int amount) async {// fungsi untuk menangani pembayaran UTS
    _showLoadingDialog(context);

    final response = await http.get(
      Uri.parse(
        '${widget.url}/payment-uts/${widget.uuid}/$amount/${selectedKelasUts}',
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

  Future<void> _handlePayment3(int amount) async {// fungsi untuk menangani pembayaran UAS
    _showLoadingDialog(context);

    final response = await http.get(
      Uri.parse(
        '${widget.url}/payment-uas/${widget.uuid}/$amount/${selectedKelasUas}',
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

  Widget _buildDropdown({// fungsi untuk membuat dropdown kelas
    required String label,
    required String? selectedValue,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue,
                hint: Text('Pilih $label'),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tagihan Transaksi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF03A9F4),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Pendaftaran', icon: Icon(Icons.note_add_sharp)),
              Tab(text: 'SPP Bulanan', icon: Icon(Icons.drafts)),
              Tab(text: 'Ujian Tengah', icon: Icon(Icons.note_alt_rounded)),
              Tab(text: 'Ujian Akhir', icon: Icon(Icons.pending_actions_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Pendaftaran
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (sisa <= 0)
                          Text('Tidak ada tagihan')
                        else
                          Card(
                          color: const Color.fromARGB(255, 255, 253, 253),
                          child: ListTile(
                            leading: const Icon(Icons.note_add_sharp),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pendaftaran sekolah'),
                                Text(
                                  'Sisa Tagihan',
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
                                TextEditingController _amountController = TextEditingController(
                                  text: sisa.toString(),
                                );

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Masukkan Nominal Pembayaran'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                           Text(
                                            'Maksimal pembayaran Pendaftaran adalah Rp500.000, \nCicilan dimulai dengan nominal 50.000',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
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
                                              hintText: 'Contoh: 500000',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context); // tutup dialog
                                            int defaultAmount = 700000;

                                            // ✅ Validasi minimal & maksimal
                                            if (defaultAmount < 50000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Minimal pembayaran adalah Rp50.000')),
                                              );
                                              return;
                                            }
                                            if (defaultAmount > 500000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Maksimal pembayaran pendaftaran adalah Rp500.000')),
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
                                            int? customAmount =
                                                int.tryParse(_amountController.text);

                                            if (customAmount == null || customAmount <= 0) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Nominal tidak valid')),
                                              );
                                              return;
                                            }

                                            // ✅ Validasi minimal & maksimal
                                            if (customAmount < 50000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Minimal pembayaran adalah Rp50.000')),
                                              );
                                              return;
                                            }
                                            if (customAmount > 500000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Maksimal pembayaran pendaftaran adalah Rp500.000')),
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
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tab 2: SPP Bulanan
            Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 12; i++)
                          Card(
                            color: const Color.fromARGB(255, 255, 253, 253),
                            child: ListTile(
                              leading: const Icon(Icons.sticky_note_2_sharp),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('SPP Bulan ${urutanBulan[i]}')],
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TagihanSpp(
                                      bulan: urutanBulan[i],
                                      url: widget.url,
                                      uuid: widget.uuid,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tab 3: Ujian Tengah (UTS)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      _buildDropdown(
                        label: 'Kelas',
                        selectedValue: selectedKelasUts,
                        items: kelasList,
                        onChanged: (value) {
                          setState(() {
                            selectedKelasUts = value;
                            data2 = ''; // reset data2 agar reload
                          });
                          fetchUts();
                        },
                      ),

                      const SizedBox(width: 12),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (sisa2 <= 0)
                          Text('Tidak ada tagihan')
                        else
                         Card(
                        color: const Color.fromARGB(255, 255, 253, 253),
                        child: ListTile(
                          leading: const Icon(Icons.note_add_sharp),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ujian Tengah'),
                              Text(
                                'Sisa Tagihan',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            formatRupiah(sisa2),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.red,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              TextEditingController _amountController =
                                  TextEditingController(text: sisa2.toString());

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Masukkan Nominal Pembayaran'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                       Text(
                                            'Maksimal pembayaran UAS adalah Rp350.000, \nTolong Langsung Bayar Lunas',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                        Text(
                                          'Biaya default: ${formatRupiah(sisa2)}\n\nIsi nominal khusus jika ingin bayar sebagian.',
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
                                            hintText: 'Contoh: 200000',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context); // tutup dialog
                                          int defaultAmount = 200000; // contoh default

                                          // ✅ Validasi minimal
                                          if (defaultAmount < 50000) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Minimal pembayaran UTS adalah Rp50.000')),
                                            );
                                            return;
                                          }
                                          // ✅ Validasi maksimal
                                          if (defaultAmount > 350000) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Maksimal pembayaran UTS adalah Rp350.000')),
                                            );
                                            return;
                                          }

                                          await _handlePayment2(defaultAmount);
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
                                          if (customAmount < 50000) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Minimal pembayaran UTS adalah Rp50.000')),
                                            );
                                            return;
                                          }
                                          // ✅ Validasi maksimal
                                          if (customAmount > 350000) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Maksimal pembayaran UTS adalah Rp350.000')),
                                            );
                                            return;
                                          }

                                          await _handlePayment2(customAmount);
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

                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tab 4: Ujian Akhir (UAS)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      _buildDropdown(
                        label: 'Kelas',
                        selectedValue: selectedKelasUas,
                        items: kelasList,
                        onChanged: (value) {
                          setState(() {
                            selectedKelasUas = value;
                            data3 = ''; // reset data3 agar reload
                          });
                          fetchUas();
                        },
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (sisa3 <= 0)
                          Text('Tidak ada tagihan')
                        else
                         Card(
                          color: const Color.fromARGB(255, 255, 253, 253),
                          child: ListTile(
                            leading: const Icon(Icons.note_add_sharp),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ujian Akhir'),
                                Text(
                                  'Sisa Tagihan',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              formatRupiah(sisa3),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.red,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                TextEditingController _amountController =
                                    TextEditingController(text: sisa3.toString());

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Masukkan Nominal Pembayaran'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Maksimal pembayaran UAS adalah Rp370.000, \nTolong Langsung Bayar Lunas',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Biaya default: ${formatRupiah(sisa3)}\n\nIsi nominal khusus jika ingin bayar sebagian.',
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
                                              hintText: 'Contoh: 200000',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context); // tutup dialog
                                            int defaultAmount = 200000; // contoh default

                                            // ✅ Validasi minimal
                                            if (defaultAmount < 50000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Minimal pembayaran UAS adalah Rp50.000')),
                                              );
                                              return;
                                            }
                                            // ✅ Validasi maksimal
                                            if (defaultAmount > 370000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Maksimal pembayaran UAS adalah Rp370.000')),
                                              );
                                              return;
                                            }

                                            await _handlePayment3(defaultAmount);
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
                                            if (customAmount < 50000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Minimal pembayaran UAS adalah Rp50.000')),
                                              );
                                              return;
                                            }
                                            // ✅ Validasi maksimal
                                            if (customAmount > 370000) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Maksimal pembayaran UAS adalah Rp370.000')),
                                              );
                                              return;
                                            }

                                            await _handlePayment3(customAmount);
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

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
