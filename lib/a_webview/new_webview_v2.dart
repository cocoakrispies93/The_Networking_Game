// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;
  late final WebView _controller; // = NavigationControls();

  @override
  void initState() {
    super.initState();

    _controller = WebView(
      initialUrl:
          'https://www.indeed.com/?from=gnav-employer--post-press--jobseeker',
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (request) {
        if (request.url.startsWith('https://www.indeed.com')) {
          // Allow the request
          return NavigationDecision.navigate;
        }
        // Don't allow the request
        return NavigationDecision.prevent;
      },
      onWebViewCreated: (webViewController) {
        _controller = webViewController as WebView;
      },
      onPageStarted: (indeedURL) {
        setState(() {
          loadingPercentage = 0;
        });
      },
      onProgress: (progress) {
        setState(() {
          loadingPercentage = progress * 100;
        });
      },
      onPageFinished: (url) {
        setState(() {
          loadingPercentage = 100;
        });
      },
    );
    if (loadingPercentage < 100) {
      LinearProgressIndicator(
        value: loadingPercentage / 100.0,
      );
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   widget.controller
  //     .setNavigationDelegate(
  //       NavigationDelegate(
  //         onPageStarted: (url) {
  //           setState(() {
  //             loadingPercentage = 0;
  //           });
  //         },
  //         onProgress: (progress) {
  //           setState(() {
  //             loadingPercentage = progress as int;
  //           });
  //         },
  //         onPageFinished: (url) {
  //           setState(() {
  //             loadingPercentage = 100;
  //           });
  //         },
  //         onNavigationRequest: (navigation) {
  //           final host = Uri.parse(navigation.url as String).host;
  //           if (host.contains('youtube.com')) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(
  //                   'Blocking navigation to $host',
  //                 ),
  //               ),
  //             );
  //             return NavigationDecision.prevent;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     );
  //   // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   //javascriptMode: JavascriptMode.unrestricted,
  //   // ..q
  //   // ..addJavaScriptChannel(
  //   //   'SnackBar',
  //   //   onMessageReceived: (message) {
  //   //     ScaffoldMessenger.of(context)
  //   //         .showSnackBar(SnackBar(content: Text(message.message as String)));
  //   //   },
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //WebViewStack(
        //widget.controller: _controller,
        //),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}
