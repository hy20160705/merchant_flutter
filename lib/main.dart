import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/common/router_config.dart';
import 'package:merchant_flutter/ui/login_screen.dart';
import 'package:merchant_flutter/ui/main_screen.dart';
import 'package:merchant_flutter/utils/sp_util.dart';
import 'package:merchant_flutter/utils/theme_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:merchant_flutter/widgets/refresh_helper.dart';

import 'net/dio_manager.dart';

/// 在拿不到context的地方通过navigatorKey进行路由跳转：
/// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPUtil.getInstance();
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  /** 主题模式 */
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    _initAsync();
    themeData = ThemeUtils.getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => MaterialClassicHeader(),
        footerBuilder: () => RefreshFooter(),
        // 头部触发刷新的越界距离
        headerTriggerDistance: 80.0,
        // 可以通过惯性滑动触发加载更多
        enableBallisticLoad: true,
        //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableScrollWhenRefreshCompleted: true,
        child: MaterialApp(
          title: AppConfig.appName,
          // 去掉debug图标
          debugShowCheckedModeBanner: false,
//          initialRoute: RouterName.splash,
          // 存放路由的配置
          routes: Router.generateRoute(),
          navigatorKey: navigatorKey,
          theme: themeData,
          home: _getHome(),
        ));
  }

  void _initAsync() async {
    await DioManager.init();
  }
  Widget _getHome() {
    return SPUtil.getString(Constants.TOKEN_KEY).isEmpty
        ? LoginScreen()
        : MainScreen();
  }
}
