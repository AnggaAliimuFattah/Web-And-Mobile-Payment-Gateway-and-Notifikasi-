import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:school_ypi_new_two/pages/transaksi/detail-pendaftaran/detail-pendaftaran.dart';
import 'package:school_ypi_new_two/pages/transaksi/detail-spp/spp.dart';
import 'package:school_ypi_new_two/pages/transaksi/detail-uas/detail-uas.dart';
import 'package:school_ypi_new_two/pages/transaksi/detail-uts/detail-uts.dart';



class Bukti extends StatefulWidget {
  final String url;
  final String uuid;
  const Bukti({super.key, required this.url, required this.uuid});

  @override
  State<Bukti> createState() => _BuktiState();
}

class _BuktiState extends State<Bukti> with SingleTickerProviderStateMixin {
  List<dynamic> data = [];
  List<dynamic> data2 = [];
  List<dynamic> data3 = [];

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

  void _handleTabSelection() {//ffungsi untuk menangani perubahan tab
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

  Future<void> fetchPendaftaran() async {// fungsi untuk mengambil data pendaftaran
    setState(() => isLoading = true);
    _showLoadingDialog(context);

    try {
      final uris = Uri.parse(
        '${widget.url}/riwayat-tagihan-pendaftaran/${widget.uuid}',
      );
      final response = await http.get(uris);

      if (response.statusCode == 200) {
        final apiData = json.decode(response.body);
        setState(() {
          data = apiData ?? [];
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

  Future<void> fetchUts() async {// fungsi untuk mengambil data UTS
    setState(() => isLoading = true);
    _showLoadingDialog(context);

    try {
      final url = Uri.parse('${widget.url}/riwayat-tagihan-uts');
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
        setState(() {
          data2 = apiData2 ?? [];
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
      final url = Uri.parse('${widget.url}/riwayat-tagihan-uas');
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
          data3 = apiData3 ?? [];
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

  String formatRupiah(dynamic number) {//fffungsi untuk memformat angka menjadi format rupiah
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

  List<Widget> buildPendaftaranList() {//ui untuk menampilkan daftar pendaftaran
    if (data.isEmpty) {
      return [const Text('Tidak ada data pendaftaran.')];
    }

    return data.map<Widget>((item) {
      return Card(// bungkus data pendaftaran
        color: const Color.fromARGB(255, 255, 253, 253),
        child: ListTile(
          leading: const Icon(Icons.note_add_sharp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailPendaftaran(url: widget.url, uuid: item['uuid']),
              ),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pendaftaran sekolah'),
              Text(
                item['status'] ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          subtitle: Text(
            formatRupiah(item['nominal']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.green,
            ),
          ),
          trailing: Text(
            formatRupiah(item['sisa']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> buildUtsList() {//ui untuk menampilkan daftar UTS
    if (data2.isEmpty) {
      return [const Text('Tidak ada data UTS.')];
    }

    return data2.map<Widget>((item) {
      return Card(
        color: const Color.fromARGB(255, 255, 253, 253),
        child: ListTile(
          leading: const Icon(Icons.note_add_sharp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailUts(url: widget.url, uuid: item['uuid']),
              ),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ujian Tengah'),
              Text(
                item['status'] ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          subtitle: Text(
            formatRupiah(item['nominal']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.green,
            ),
          ),
          trailing: Text(
            formatRupiah(item['sisa']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> buildUasList() {// ui untuk menampilkan daftar UAS
    if (data3.isEmpty) {
      return [const Text('Tidak ada data UAS.')];
    }

    return data3.map<Widget>((item) {
      return Card(
        color: const Color.fromARGB(255, 255, 253, 253),
        child: ListTile(
          leading: const Icon(Icons.note_add_sharp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailUas(url: widget.url, uuid: item['uuid']),
              ),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ujian Akhir'),
              Text(
                item['status'] ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          subtitle: Text(
            formatRupiah(item['nominal']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.green,
            ),
          ),
          trailing: Text(
            formatRupiah(item['sisa']),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDropdown({// 
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
            'Bukti Transaksi',
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
                    child: Column(children: buildPendaftaranList()),
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
                                    builder: (context) => Spp(
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
                            data2 = []; // reset data2 agar reload
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
                    child: Column(children: buildUtsList()),
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
                            data3 = []; // reset data3 agar reload
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
                    child: Column(children: buildUasList()),
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
