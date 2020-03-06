import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:merchant_flutter/widgets/refresh_helper.dart';
import 'package:merchant_flutter/model/enterpise_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/utils.dart';
import 'package:merchant_flutter/widgets/image_view.dart';

class EnterPriseScreenItem extends StatefulWidget {
  int type;

  @override
  State<StatefulWidget> createState() {
    return EnterPriseScreenItemState();
  }

  EnterPriseScreenItem(this.type);
}

class EnterPriseScreenItemState extends State<EnterPriseScreenItem> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Enterprise> data = new List();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
//    for (var i; i < (10); i++) {
    data.add(new Enterprise(
        shopId: 1,
        shopAddress: '贵州省' + '1',
        shopName: '何勇小店+i',
        shopImage: '',
        todaySalesVolume: '80.00',
        businessTypeName: '哈哈哈' + '1',
        contactsName: '何勇' + '1',
        ifOrder: false,
        mobile: '15751004145'));
//    }
  }

  @override
  Widget build(BuildContext context) {
    int type = widget.type;
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: RefreshFooter(),
        onRefresh: _onRefresh(),
        onLoading: _onLoading(),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: _itemView,
        ),
      ),
    );
  }

  /// 下拉刷新
  _onRefresh() {}

  ///上拉加载
  _onLoading() {}

  Widget _itemView(BuildContext context, int index) {
    Enterprise item = data[index];
    return Card(
        color: Colors.white,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Container(
            height: 108.0,
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              height: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ImageWidget(
                    url:item.shopImage,
                    w: 87.0,
                    h: 87.8,
                    defImagePath: Utils.getImgPath('ic_default_128'),
                  ),
                  Expanded(
                      flex: 1,
                      child: Stack(children: <Widget>[
                        Positioned(
                            height: 28.0,
                            width: 28.0,
                            top: 30.0,
                            right: 0,
                            child:
                                Image.asset(Utils.getImgPath('ic_call_phone'))),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.shopName,
                              style: TextStyle(
                                  color: Colours.color_333, fontSize: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 5.0, top: 6.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colours.color_FF714A,
                                            width: 0.5,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                      ),
                                      padding: EdgeInsets.fromLTRB(6, 1, 6, 1),
                                      child: Text(
                                        item.businessTypeName,
                                        style: TextStyle(
                                            color: Colours.color_FF714A,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        item.contactsName,
                                        style: TextStyle(
                                            color: Colours.color_999,
                                            fontSize: 12.0),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "今日销售额:",
                                        style: TextStyle(
                                            color: Colours.color_999,
                                            fontSize: 12.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: item.todaySalesVolume,
                                              style: TextStyle(
                                                  color: Colours.color_999,
                                                  fontSize: 12.0))
                                        ]),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Text(item.shopAddress),
                                )
                              ],
                            )
                          ],
                        )
                      ]))
                ],
              ),
            )));
  }
}
