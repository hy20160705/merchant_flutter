import 'package:flutter/material.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/ui/login_screen.dart';
import 'package:merchant_flutter/ui/main_screen.dart';
import 'package:merchant_flutter/utils/screen_adapter.dart';
import 'package:merchant_flutter/utils/sp_util.dart';

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
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => _getHome()),
          (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Image.asset(
      "assets/images/launch_image.png",
      fit: BoxFit.fill,
    );
  }
  Widget _getHome() {
    return SPUtil.getString(Constants.TOKEN_KEY).isEmpty
        ? LoginScreen()
        : MainScreen();
  }

}
