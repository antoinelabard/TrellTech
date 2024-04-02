import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/service/_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:developer';

//auth in trello with autorize
class Auth with ChangeNotifier, DiagnosticableTreeMixin {
  static const String apiKey = '725b95d186279c0bcc9f9ff473cf0604';
  String? apiToken;

  void _setToken(String token) {
    apiToken = token;
    notifyListeners();
    log("updated token : $apiToken");
  }

  Future<WebViewController> signUp() async {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            //show url in console
            log(url);
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://trello.com/1/token/approve')) {
              // extract token
              _setToken(request.url.split('=')[1]);
              log("connected with token");
              log(apiToken!);

              // close webview
              router.push('/home');
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://trello.com/1/authorize?expiration=never&name=UwU&scope=read,write&key=$apiKey&response_type=token&return_url=https://trello.com/1/token/approve'));

    return controller;
  }

  void signIn() {}

  void signOut() {
    apiToken = null;
    notifyListeners();
    router.pushReplacement('/');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // list all the properties of your class here.
    // See the documentation of debugFillProperties for more information.
    properties.add(StringProperty('apiToken', apiToken));
    properties.add(StringProperty('apiKey', apiKey));
  }
}
