import 'package:flutter/material.dart';
import 'package:merchant_flutter/ui/main_screen.dart';
import 'package:merchant_flutter/utils/screen_adapter.dart';

/**
 * 启动页面
 */

/// 启动页面
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

//    Future.delayed(Duration(seconds: 2), () {
//      Navigator.of(context).pushAndRemoveUntil(
//          new MaterialPageRoute(builder: (context) => MainScreen()),
//          (route) => route == null);
//    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Image.asset(
      "assets/images/ic_laucher.png",
      fit: BoxFit.fill,
    );
  }
}
