import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPagePayment extends StatefulWidget {
  final String url;

  const WebViewPagePayment({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewPagePayment> createState() => _WebViewPagePaymentState();
}

class _WebViewPagePaymentState extends State<WebViewPagePayment> {
  late final WebViewController _controller;
  final _scrollController = ScrollController();

  Future<void> _handleRefresh() async {
    await _controller.reload();
    await Future.delayed(const Duration(seconds: 1)); // Untuk animasi refresh
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;
            print("Intercepted URL: $url");

            // ✅ Jika mengarah ke metode pembayaran seperti QRIS, Gopay, dsb
            if (_isExternalPaymentUrl(url)) {
              _launchExternal(url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            print("Loading: $url");
          },
          onPageFinished: (url) {
            print("Loaded: $url");
          },
          onWebResourceError: (error) {
            print("WebView error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  bool _isExternalPaymentUrl(String url) {
    return url.contains('qris') ||
        url.contains('gopay') ||
        url.contains('shopeepay') ||
        url.contains('intent') ||
        url.startsWith('gojek://') ||
        url.startsWith('shopeeid://');
  }

  void _launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Gagal membuka URL eksternal: $url');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka aplikasi pembayaran'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran Midtrans')),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: WebViewWidget(controller: _controller),
          ),
        ),
      ),
    );
  }
}
