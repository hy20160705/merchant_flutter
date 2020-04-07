import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:merchant_flutter/model/req/shop_req.dart';
import 'package:merchant_flutter/model/req/shop_search_req.dart';
import 'package:merchant_flutter/model/resp/shop_list_model.dart';
import 'package:merchant_flutter/model/resp/shop_search_list_model.dart';
import 'package:merchant_flutter/ui/base_screen.dart';
import 'package:merchant_flutter/utils/route_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:merchant_flutter/widgets/refresh_helper.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/utils.dart';
import 'package:merchant_flutter/widgets/image_view.dart';

import '../net/api/api_service.dart';
import '../res/colors.dart';
import '../utils/toast_util.dart';

class EnterPriseScreenItem extends BaseScreen {
  int type;

  @override
  State<StatefulWidget> createState() {
    return EnterPriseScreenItemState();
  }

  EnterPriseScreenItem(this.type);

  @override
  BaseScreenState<BaseScreen> attachState() {
    return EnterPriseScreenItemState();
  }
}

enum EOrderType { comprehensive, distance }

class EnterPriseScreenItemState extends BaseScreenState<EnterPriseScreenItem> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<dynamic> _data = new List();

  // 拍讯方式 1：综合 2：距离
  int _orderBy = 1;
  int _next;

  /// 是否是按照距离排序
  bool _isDistance = false;

  @override
  void initState() {
    super.initState();
    setAppBarVisible(false);
  }

  @override
  AppBar attachAppBar() {
    return AppBar(title: Text(""));
  }

  @override
  Widget attachContentWidget(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Card(
          elevation: 0.0,
          color: Colors.white,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 30.0,
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Text(
                      "综合",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: _isDistance
                              ? Colours.color_333
                              : Colours.color_FF714A),
                    ),
                    onTap: () {
                      _orderByType(EOrderType.comprehensive);
                    },
                  ),
                ),
                SizedBox(
                  width: 1,
                  height: 15.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colours.color_ccc,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Text(
                      "距离",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: _isDistance
                              ? Colours.color_FF714A
                              : Colours.color_333),
                    ),
                    onTap: () {
                      _orderByType(EOrderType.distance);
                    },
                  ),
                ),
              ],
            ),
          )),
      Expanded(
        child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: widget.type == 0,
            header: MaterialClassicHeader(),
            footer: RefreshFooter(),
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: _addContent()),
      )
    ]));
  }

  @override
  void onClickErrorWidget() {
    showLoading().then((value) {
      _onRefresh();
    });
  }

  /// 构建itemView
  Widget _itemView(BuildContext context, int index) {
    var item = _data[index];
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
                        Positioned(
                            top: 0.0,
                            right: 0,
                            child: Text(
                                item.distance == null ? '' : item.distance,
                                style: TextStyle(
                                    color: Colours.color_999, fontSize: 12.0))),
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
                                Container(
                                  margin: EdgeInsets.only(right: 5.0, top: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colours.color_FF714A,
                                              width: 0.5,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3.0)),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(6, 1, 6, 1),
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
                                        margin: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: SizedBox(
                                          width: 1,
                                          height: 11.0,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colours.color_999,
                                            ),
                                          ),
                                        ),
                                      ),
                                      _buildSign(item),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                ),
                                // 标签+联系人

                                Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                        '今日销售额: ' +
                                            (item.todaySalesVolume == null
                                                ? ""
                                                : item.todaySalesVolume),
                                        style: TextStyle(
                                            color: Colours.color_999,
                                            fontSize: 12.0))),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(item.shopAddress,
                                      style: TextStyle(
                                          color: Colours.color_999,
                                          fontSize: 12.0)),
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

  /// 构建签到状态样式
  Widget _buildSign(item) {
    if (item.ifSignIn) {
      return Text(
        '今日已签到',
        style: TextStyle(color: Colours.color_999, fontSize: 12.0),
      );
    }
    return InkWell(
      onTap: () => _goToSign(item.shopId),
      child: Text(
        "未签到",
        style: TextStyle(
            color: Colours.color_FF714A,
            fontSize: 12.0,
            decoration: TextDecoration.underline),
      ),
    );
  }

  /// 下拉刷新
  _onRefresh() {
    print('_onRefresh status=${widget.type}');
    print('_onRefresh _orderBy=$_orderBy');
    if (widget.type == 0) {
      _next = 0;
      _getSearchShops();
    } else {
      _getMyShops();
    }
  }

  ///上拉加载
  _onLoading() {
    _getMoreSearchShops();
  }

  /// 获取今日和昨日下单列表
  void _getMyShops() {
    ShopReq shopReq = new ShopReq(
        salerLatitude: "0.0",
        salerLongitude: "0.0",
        status: widget.type,
        orderBy: _orderBy);
    apiService.getMyShops(shopReq, (ShopListModel res) {
      _refreshController.refreshCompleted(resetFooterState: true);
      _data.clear();
      setState(() {
        _data.addAll(res.data);
      });
      showContent();
    }, (error) {
      showError();
      _refreshController.refreshFailed();
      T.show(msg: error.message);
    });
  }

  /// 获取全部列表
  void _getSearchShops() {
    print('_getSearchShops _next=$_next');
    ShopSearchReq shopReq = new ShopSearchReq(
        salerLatitude: "0.0",
        salerLongitude: "0.0",
        next: _next,
        orderBy: _orderBy);

    apiService.getMyShopsBySearch(shopReq, (ShopSearchListModel res) {
      _refreshController.refreshCompleted(resetFooterState: true);
      Data data = res.data;
      setState(() {
        _next = data.next;
        _data.clear();
        _data.addAll(res.data.records);
      });
      showContent();
    }, (error) {
      _refreshController.refreshFailed();
      T.show(msg: error.message);
      showError();
    });
  }

// 全部 加载更多
  void _getMoreSearchShops() {
    print('_getMoreSearchShops _next=$_next');
    if (_next <= 0) {
      _refreshController.loadNoData();
      return;
    }
    ShopSearchReq shopReq = new ShopSearchReq(
        salerLatitude: "0.0",
        salerLongitude: "0.0",
        next: _next,
        orderBy: _orderBy);
    apiService.getMyShopsBySearch(shopReq, (ShopSearchListModel res) {
      _refreshController.loadComplete();
      Data data = res.data;
      if (data.next <= 0) {
        _refreshController.loadNoData();
      }
      setState(() {
        _next = data.next;
      });
      if (data.records.length > 0) {
        setState(() {
          _data.addAll(res.data.records);
        });
      } else {
        _refreshController.loadNoData();
      }
    }, (error) {
      _refreshController.loadFailed();
      T.show(msg: error.message);
    });
  }

  /// 排序切换
  _orderByType(EOrderType type) {
    debugPrint('_orderByType$type');
    switch (type) {
      case EOrderType.comprehensive:
        setState(() {
          _orderBy = type.index + 1;
          _isDistance = false;
        });
        break;
      case EOrderType.distance:
        setState(() {
          _orderBy = type.index + 1;
          _isDistance = true;
        });
        break;
    }
    _onRefresh();
  }

  /// 跳转到签到页面
  _goToSign(int shopId) {
    debugPrint('跳转到签到页面$shopId');
    RouteUtil.toWebView(context, '', 'https://www.baidu.com');
  }

  Widget _addContent() {
    if (_data.length <= 0) {
      return attachEmptyWidget();
    } else {
      return ListView.builder(
        itemCount: _data.length,
        itemBuilder: _itemView,
        physics: new AlwaysScrollableScrollPhysics(),
      );
    }
  }
}
