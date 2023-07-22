import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/NewsModel.dart';

class WebViewScreen extends StatelessWidget {
  static const String routeName = "WebViewScreen";
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    var articles = ModalRoute.of(context)?.settings.arguments as Articles;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(Uri.parse(articles.url ?? ""));
    return Scaffold(
      appBar: AppBar(
        title: Text(articles.title ?? ""),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
        ),
        elevation: 0,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
