import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_flutter/ui/index.dart';

import '../ui/login_screen.dart';

/// 存放路由的配置
class RouterName {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String web_view = '/web_view';
}

class Router {
  static Map<String, WidgetBuilder> generateRoute() {
    Map<String, WidgetBuilder> routes = {
      RouterName.splash: (context) => new SplashScreen(),
      RouterName.login: (context) => new LoginScreen(),
      RouterName.main: (context) => new MainScreen(),
    };
    return routes;
  }
}
