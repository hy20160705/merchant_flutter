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
    with SingleTickerProviderStateMixin {
  TabController mController;
  List<Tab> tabList = new List();

  @override
  void initState() {
    super.initState();
    initData();
    mController = TabController(length: tabList.length, vsync: this);
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
                controller: mController,
                tabs: tabList,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ],
          )

//
          ),
      Expanded(
        child: TabBarView(
          controller: mController,
          children: tabList.map((item) {
            return Stack(
              children: <Widget>[
                EnterPriseScreenItem(1),
                EnterPriseScreenItem(2),
                EnterPriseScreenItem(3),
              ],
            );
          }).toList(),
        ),
      ),
    ]));
  }

  void initData() {
    tabList = [
      new Tab(
        text: '全部',
      ),
      new Tab(
        text: '今日下单',
      ),
      new Tab(
        text: '今日未下单',
      ),
    ];
  }
}
