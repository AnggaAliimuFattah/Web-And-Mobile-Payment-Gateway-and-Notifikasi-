import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_ypi_new_two/pages/notifikasi/notifikasi.dart';
import 'package:school_ypi_new_two/pages/profile_page.dart';
import 'package:school_ypi_new_two/pages/transaksi/bukti.dart';
import 'dart:convert';

import 'package:school_ypi_new_two/pages/transaksi/tagihan.dart';

class DashboardPage extends StatefulWidget {
  //initializing variables
  final url;
  final uuid;
  final nama;
  final username;
  final token;
  const DashboardPage({
    super.key,
    required this.url,
    required this.uuid,
    required this.nama,
    required this.username,
    required this.token,
  });
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //memasukkan variabel yang dibutuhkan
  late String nama;
  late String uuid;
  bool isLoading = false;
  late String nis = "";
  late String kelas = "";
  final String foto =
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAdVBMVEX///8AAAB8fHzb29v4+Pj7+/v19fXBwcHf39+KiopycnJFRUViYmKbm5vs7OyxsbG4uLiCgoLT09PHx8cuLi40NDRLS0ugoKApKSnl5eWOjo7t7e1sbGypqakfHx9AQEAMDAxVVVVlZWUbGxsUFBRYWFjNzc1gmD6SAAAETElEQVR4nO3diXaqMBAGYCNCAcUFtS6tVu3y/o94tb226AFJJjjDtP/3BPOfIiSTpZ0OAAAAAAAAAAAAAAAAAAAAAAAAwJ8UBeNsPelOkmyUP0kX07xp0jdF8+64J11Tg4KuKTN4kC6sIdPH0nwns5F0cQ2I95X5Pp9W9X/H5Ga+z2dV9VsnmNUGPBpLl0k3tsl3lEgXSpVZBjTmOZSulWRtHfD4Y5QulsL+L/j5V5Qu193IKaAxqXTBrnLHgMZspEt2E26dE5pYumgn5QPR2+bSRbv4IAQ0JpMu28ELKaEZStdtzXYsc03P+3ROTGhW0pVbmlIDmrV06ZbeyQmNdOl2nugBjY75sOt4rUjHu2bgkXAnXbwVj4A6hm6xV0IN42+fn6ExE+nyLbjNfK/tpcu3QJlW/HiRLt/C3ivhVkFPqrqHbyWSrr8eEv71hDsFq4o+gzZjZgreNBOvhH3p8i0svBIepMu3QJ/hn2iY5Q+9EqqYApP7UCcqFoR9XjUahqV+P0QNP8OO1yQ/kK7dTv3+iyo6HtJOZ0VOqGZXxoEYcClduLWAmFDRHrCUFFDTEmm0oyT8kC7bBWUFUUMjseDZOeBMumRH4dI1oZbV0W/DN7eAKiYVl2Knt42ab31R4BBRZcDj6M16Y5TCR/RLtLfK96ph0bCKzUJUqqBFekPcr8m3nUqX6G18azf7LlPQAa43rtrmts0UrFLYCZKSIU46/RV/v2+rTdo/fz12L4eFko6Mo3AYB3kQD3W/PAEAAOCPi4ar05gmWA1/zYD7LMo360G/OPhe9gfJJv8dQVejtHphf56O1LVJL+Vls6YrsySXLpOqdFJYapkonEuFI7cdfI+K1g5PepljT//oLdMzbYxczqkXrVXsF+qEC9Ly6JeFdPUWplZXYVSat719+kTdhvHj0OpxAPV47KX2LkSF7kvb5dp6EYjdZTRWZq0c5jTzhJ618EmlfgOrtG4fJm0X1C3tOjDb2zce0Jh9a943YSesWwal6bfmy9i7T8AWRfS4YaBGS06UNv+S+dGK66Pou7pttOAqN7+j2/XE5/5+p+9tCLdwes6bLJ1tZV+o/tPBeqIH9jYMAUV/in4H8ezJ9cX9jvzae5cK+MAUUG62+MqW8E0moN8lJm5EruOLGAPKnJ6973j0msCBGq4vxRn/nYpNd57qsE8yeswBjeFee+MZrxVx3wJ2/znFNeYjtO4XIfvj7fT7XehFw9oi5n/PHO04O8R8Y+4izuVhiYfUmC5fwLC5lUIXS77HlHqjgC++tpvfVVB0fHtRODpsZfj+Cwbh3wI04pXrh0i/ncUXV9NN5mt4wnUimrNBc4mrXdPUxiB3XMuJ91rUrsd1j5RYQK5790UmFv/xtDK4u2xFPB23+y/7VuO5X0Kig3HGc5WU3wWlfng++XJDGiRsSp52paSt3DsMAAAAAAAAAAAAAAAAAAAAAAAAYO8fPkg86n0Nbj8AAAAASUVORK5CYII=";
  String getCurrentMonthYearLabel() {
    final now = DateTime.now();
    const bulan = [
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
    final namaBulan = bulan[now.month - 1];
    return '$namaBulan';
    final year = now.year;
  }

  @override
  void initState() {
    super.initState();
    nama = widget.nama;
    uuid = widget.uuid;
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
        kelas = data['kelas'];
        nis = data['nis'];

        print('Kelas: $kelas');
        print('NIS: $nis');

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
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = screenHeight * 0.3; // misal 30% tinggi layar
    return Scaffold(
      backgroundColor: Color(0xFFF1F4FA),

      body: Stack(
        children: [
          // AppBar custom dengan bentuk kubah (melengkung di bawah)
          ClipPath(
            clipper: BottomCurveClipper(),
            child: Container(
              height: screenHeight * 0.25, // Lebih tinggi supaya lengkung jelas
              color: Color.fromARGB(255, 55, 149, 243),
              alignment: Alignment.center,
              child: Padding(padding: const EdgeInsets.only(top: 0.0)),
            ),
          ),

          // Konten utama di atas AppBar, beri padding top supaya gak tertutup
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(),
                SizedBox(height: 20),
                _buildAcademicCard(),
                SizedBox(height: 24),
                Text(
                  "Menu Utama",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                _buildMenuGrid(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
// dashboard berisi bgian profil, 
  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 55, 149, 243),
        // borderRadius: BorderRadius.circular(16),
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      padding: EdgeInsets.only(top: 55, left: 20, right: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 36, backgroundImage: NetworkImage(foto)),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text("NIS: $nis", style: TextStyle(color: Colors.white70)),
                Text("Kelas: $kelas", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
// dashboard berisi tahun dan bulan
  Widget _buildAcademicCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoColumn("Bulan Ini", "Tahun"),

          _infoColumn(getCurrentMonthYearLabel(), "2025"),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,// tahun text
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
//dashboard icon
  Widget _buildMenuGrid(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.receipt_long_rounded,
        'label': 'Tagihan Biaya',
        'page': Tagihan(url: widget.url, uuid: uuid),
        'color': const Color.fromARGB(255, 244, 41, 34),
      },
      {
        'icon': Icons.receipt_outlined,
        'label': 'Bukti Transaksi',
        'page': Bukti(url: widget.url, uuid: uuid),
        'color': const Color.fromARGB(255, 26, 231, 50),
      },
      {
        'icon': Icons.notifications,
        'label': 'Activity Bayar',
        'page': Notifikasi(url: widget.url, uuid: uuid),
        'color': const Color.fromARGB(255, 234, 244, 34),
      },
      {
        'icon': Icons.account_circle,
        'label': 'Profil',
        'page': ProfilePage(url: widget.url, uuid: uuid),
        'color': const Color.fromARGB(255, 34, 167, 244),
      },
    ];
    
    // grid untuk beberapa menu
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item['page'] as Widget),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  size: 30,
                  color: item['color'] as Color,
                ),
                SizedBox(height: 8),
                Text(
                  item['label'] as String,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Pindahkan class clipper ke luar class DashboardPage (top-level class)
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 40, // titik kontrol di bawah
      size.width,
      size.height - 40, // titik akhir di bawah kanan
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
