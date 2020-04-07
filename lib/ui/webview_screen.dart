import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:merchant_flutter/ui/base_screen.dart';

class WebViewScreen extends StatefulWidget {
  final String _webUrl;
  final bool _isShowAppBar;

  WebViewScreen(this._webUrl, this._isShowAppBar);

  @override
  State<StatefulWidget> createState() {
    return WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  // 是否加载完毕
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  @override
  void initState() {
    super.initState();
//    setAppBarVisible(widget._isShowAppBar);
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
//    showContent();
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

//  @override
//  AppBar attachAppBar() {
//    return AppBar(
//      title: Text(''),
//    );
//  }
//
//  @override
//  Widget attachContentWidget(BuildContext context) {
//    return WebviewScaffold(
//      url: widget._webUrl,
//      appBar: AppBar(
//        bottom: PreferredSize(
//            child: SizedBox(
//              child: isLoad ? new LinearProgressIndicator() : Container(),
//            ),
//            preferredSize: Size.fromHeight(2.0)),
//      ),
//      javascriptChannels: jsChannels,
//      withZoom: false,
//      withLocalStorage: true,
//      withJavascript: true,
//      hidden: true,
//      resizeToAvoidBottomInset: true,
//    );
//  }
//
//  @override
//  void onClickErrorWidget() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        url: widget._webUrl,
//        appBar: AppBar(
////          title: new Text('test'),
//          bottom: PreferredSize(
//              child: SizedBox(
//                child: isLoad ? new LinearProgressIndicator() : Container(),
//              ),
//              preferredSize: Size.fromHeight(2.0)),
//        ),
        javascriptChannels: jsChannels,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        hidden: false,
      ),
    );
  }

//  Future<bool> _onWillPop() async {
//    bool isBack = true;
//    print('_onWillPop WebViewScreen');
//    await _controller.future.then((value) async {
//      print('_controller _onWillPop WebViewScreen');
//      if (await value.canGoBack()) {
//        await value.goBack();
//        isBack = false;
//      } else {
//        isBack = true;
//      }
//    });
//    return isBack;
//  }
}
