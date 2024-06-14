import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final WebViewController _controller;

  int progress = 0;

  @override
  void initState() {
    super.initState();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            const PlatformWebViewControllerCreationParams());
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress;
            });
            debugPrint('WebView is loading (progress : $progress%)');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter WebView example'),
          ),
          body: progress < 100
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: _controller)),
    );
  }
}
