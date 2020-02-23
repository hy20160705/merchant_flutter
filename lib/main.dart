import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/common/router_config.dart';
import 'package:merchant_flutter/ui/main_screen.dart';
import 'package:merchant_flutter/ui/splash_screen.dart';
import 'package:merchant_flutter/utils/theme_util.dart';

/// 在拿不到context的地方通过navigatorKey进行路由跳转：
/// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyNewApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyNewApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyNewApp> {
  /** 主题模式 */
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = ThemeUtils.getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      // 去掉debug图标
      routes: Router.generateRoute(),
      // 存放路由的配置
      navigatorKey: navigatorKey,
      theme: themeData,
      home: new MainScreen(), // 启动页
    );
  }
}