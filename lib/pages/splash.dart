import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_ypi_new_two/pages/login_page.dart';
//import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  final String url;

  // const SplashScreen({Key? key, required this.url}) : super(key: key);
  const SplashScreen({super.key, required this.url});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late String apiUrl;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    apiUrl = widget.url;
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage(url: apiUrl)),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(
            // Icons.edit,
            // size: 80.0,
            // color: Colors.cyan,
            // ),
            Image.asset(
              'assets/Logo.png', // Pastikan path dan nama file sudah benar
              width: 300.0, // Sesuaikan lebar gambar
              height: 300.0, // Sesuaikan tinggi gambar
            ),
            const SizedBox(height: 20),

            //Text("Restaurant B.L", style:  GoogleFonts.montserrat(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Color.fromARGB(232, 241, 240, 240)  ),),
          ],
        ),
      ),
    );
  }
}
