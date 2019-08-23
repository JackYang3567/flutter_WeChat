// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

 var _url = 'https://m.fmf3.cn';
class DiscoverPage extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<DiscoverPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(      
        backgroundColor: Colors.grey[200],
        actions: <Widget>[
         NavigationControls(_controller.future),    
        ],
      ),
     
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        );
      }),
   
    );
  }

  
}



class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.black,size: 16.0,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
                        );
                        return;
                      }
                    },
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16.0,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
             Padding(padding: EdgeInsets.fromLTRB(75, 0, 95, 0),),
             IconButton(
              icon: const Icon(Icons.home,color: Colors.black,size: 20.0,),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.loadUrl(_url);
                    },
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
            IconButton(
              icon: const Icon(Icons.replay,color: Colors.black,size: 20.0,),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),
             Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0),),
          ],
        );
      },
    );
  }
}
