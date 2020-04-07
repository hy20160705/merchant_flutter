import 'package:flutter/material.dart';
import 'package:merchant_flutter/ui/splash_screen.dart';
import 'package:merchant_flutter/ui/webview_screen.dart';
import 'package:merchant_flutter/utils/utils.dart';
import 'package:merchant_flutter/ui/home_screen.dart';
import 'package:merchant_flutter/ui/enterprise_screen.dart';

import 'intive_screen.dart';
import 'mine_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController = PageController();

  /// 当前选中的索引
  int _selectedIndex = 0;

  /// tabs的名字
  final bottomBarTitles = ["首页", "商户", "邀请码", "我的"];

  /// 五个Tabs的内容
  var pages = <Widget>[
//    WebViewScreen("https:www.baidu.com",false),
    HomeScreen(),
    EnterpriseScreen(),
    InviteScreen(),
    MineScreen(),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: AppBar(
          title: new Text(bottomBarTitles[_selectedIndex]),
          bottom: null,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon:
                  _selectedIndex == 1 ? Icon(Icons.search) : Icon(Icons.search),
              onPressed: () {
                if (_selectedIndex == 1) {
                  // 跳转到商户搜索 TODO
                }
              },
            )
          ],
          centerTitle: true,
        ),
        body: PageView.builder(
          itemBuilder: (context, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          // 禁止滚动
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: buildImage(0, "ic_home"), //Icon(Icons.home),
              title: Text(bottomBarTitles[0]),
            ),
            BottomNavigationBarItem(
              icon: buildImage(1, "ic_enterprise"), //Icon(Icons.home),
              title: Text(bottomBarTitles[1]),
            ),
            BottomNavigationBarItem(
              icon: buildImage(2, "ic_invite"), //Icon(Icons.home),
              title: Text(bottomBarTitles[2]),
            ),
            BottomNavigationBarItem(
              icon: buildImage(3, "ic_mine"), //Icon(Icons.home),
              title: Text(bottomBarTitles[3]),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          // 设置显示模式 平分
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          // 当前选中项的索引
          //设置默认颜色
          selectedItemColor: Color(0xff3f4251),
          unselectedItemColor: Color(0xff999999),
          selectedFontSize: 14,
          unselectedFontSize: 10,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: new Text("提示"),
              content: new Text("确定退出应用吗？"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text("再看一会",
                        style: new TextStyle(color: Colors.cyan))),
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text("退出",
                        style: new TextStyle(color: Colors.cyan))),
              ],
            ));
  }

  /// tabs 底总的图片
  Widget buildImage(index, iconPath) {
    return Image.asset(
      _selectedIndex == index
          ? Utils.getImgPath(iconPath + "_selected")
          : Utils.getImgPath(iconPath),
      width: 22,
      height: 22,
    );
  }

  void _onItemTapped(int value) {
    _pageController.jumpToPage(value);
  }
}
