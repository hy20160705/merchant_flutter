import 'package:flutter/material.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/ui/enterrise_item_screen.dart';

class EnterpriseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EnterpriseScreenState();
  }
}

class EnterpriseScreenState extends State<EnterpriseScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabList = new List();

  @override
  void initState() {
    super.initState();
    initData();
    _tabController = TabController(length: tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
          color: Colours.color_3F4251,
          width: double.infinity,
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Offstage(
                  offstage: false,
                  child: Container(
                    color: Colours.color_FF714A,
                    height: 30,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      '今日新增数: 5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  )),
              TabBar(
                isScrollable: false,
                controller: _tabController,
                tabs: tabList,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ],
          )

//
          ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          children:
          tabList.asMap().keys.toList().map((item){
            return Stack(
              children: <Widget>[
                EnterPriseScreenItem(item),
              ],
            );
          }).toList(),
//          tabList.map((item) {
//            return Stack(
//              children: <Widget>[
//                EnterPriseScreenItem(_currentIndex),
////                EnterPriseScreenItem(2),
////                EnterPriseScreenItem(3),
//              ],
//            );
//          }).toList(),
        ),
      ),
    ]));
  }

  void initData() {
    tabList = [
      new Tab(
        key: Key('0'),
        text: '全部',
      ),
      new Tab(
        key: Key('1'),
        text: '今日下单',
      ),
      new Tab(
        key: Key('2'),
        text: '今日未下单',
      ),
    ];
  }
}
