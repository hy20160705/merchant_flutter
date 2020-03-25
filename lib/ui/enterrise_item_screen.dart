import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant_flutter/model/req/shop_req.dart';
import 'package:merchant_flutter/model/shop_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:merchant_flutter/widgets/refresh_helper.dart';
import 'package:merchant_flutter/model/enterpise_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/utils.dart';
import 'package:merchant_flutter/widgets/image_view.dart';

import '../net/api/api_service.dart';
import '../net/api/apis.dart';
import '../utils/toast_util.dart';

class EnterPriseScreenItem extends StatefulWidget {
  String type;

  @override
  State<StatefulWidget> createState() {
    return EnterPriseScreenItemState();
  }

  EnterPriseScreenItem(this.type);
}

class EnterPriseScreenItemState extends State<EnterPriseScreenItem>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Shop> _data = new List();
  int _next = 0;

  @override
  void initState() {
    super.initState();
//    initData();
  }

  /// 防止页面切换导致重绘页面
  @override
  bool get wantKeepAlive => true;

//  void initData() {
//    _next = 0;
//    _getMyShops();
//  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: RefreshFooter(),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: _itemView,
//          physics: new AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }

  /// 下拉刷新
  _onRefresh() {
    print('_onRefresh${widget.type}');
    _next = 0;
    _getMyShops();
  }

  ///上拉加载
  _onLoading() {}

  Widget _itemView(BuildContext context, int index) {
    Shop item = _data[index];
    return Card(
        elevation: 0.0,
        color: Colors.white,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 108.0,
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              height: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: ImageWidget(
                      url: item.shopImage,
                      w: 87.0,
                      h: 87.8,
                      defImagePath: Utils.getImgPath('ic_default_128'),
                    ),
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
                              item.shopName == null ? '' : item.shopName,
                              style: TextStyle(
                                  color: Colours.color_333, fontSize: 15),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // 标签+联系人
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
                                        item.businessTypeName == null
                                            ? ""
                                            : item.businessTypeName,
                                        style: TextStyle(
                                            color: Colours.color_FF714A,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        item.contactsName == null
                                            ? ""
                                            : item.contactsName,
                                        style: TextStyle(
                                            color: Colours.color_999,
                                            fontSize: 12.0),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 6.0),
                                    child: Text(
                                        '今日销售额: ' + item.todaySalesVolume ==
                                                null
                                            ? ""
                                            : item.todaySalesVolume,
                                        style: TextStyle(
                                            color: Colours.color_999,
                                            fontSize: 12.0))),
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

  void _getMyShops() {
    ShopReq shopReq = new ShopReq(
        salerLatitude: "0.0", salerLongitude: "0.0", status: 1, orderBy: 1);
    apiService.getMyShops(shopReq, (ShopListModel res) {
      _refreshController.refreshCompleted(resetFooterState: true);
      _data.clear();
      setState(() {
        _data.addAll(res.data);
      });
    }, (error) {
      _refreshController.refreshFailed();
      T.show(msg: error.message);
    });
  }
}
