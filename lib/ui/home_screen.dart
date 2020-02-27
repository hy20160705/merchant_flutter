import 'package:flutter/material.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:merchant_flutter/widgets/refresh_helper.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:merchant_flutter/widgets/custom_cached_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      new RefreshController(initialRefresh: false);

  List<String> _bannerList = new List();

  @override
  void initState() {
    super.initState();
    _bannerList.add(
        'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1830914723,3154965800&fm=26&gp=0.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SmartRefresher(
        enablePullUp: false,
        enablePullDown: true,
        controller: _refreshController,
        header: MaterialClassicHeader(),
        onRefresh: getFirstPageInfo,
        child: addContentView(context),
      ),
    );
  }

  Widget addContentView(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildColumn(
                  topStr: '今日下单门店数',
                  bottomStr: '40',
                  topSize: 16,
                  startBottomSize: 56,
                  endBottomSize: 32,
                  topColor: Colors.white,
                  bottomColor: Colours.color_FEC791),
              _buildColumn(
                  topStr: '今日销售额(元)',
                  bottomStr: '40.00',
                  topSize: 16,
                  startBottomSize: 56,
                  endBottomSize: 32,
                  topColor: Colors.white,
                  bottomColor: Colours.color_FEC791),
            ],
          ),
          height: 200,
          color: Colours.color_3F4251,
          padding: EdgeInsets.only(left: 36, right: 36),
        ),
        Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 157),
            child: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildColumn(
                          topStr: '月预计收益',
                          bottomStr: '40.00',
                          topSize: 12,
                          startBottomSize: 24,
                          endBottomSize: 14,
                          topColor: Colours.color_999,
                          bottomColor: Colours.color_333),
                      _buildColumn(
                          topStr: '月累计销售额(元)',
                          bottomStr: '40.01',
                          topSize: 12,
                          startBottomSize: 24,
                          endBottomSize: 14,
                          topColor: Colours.color_999,
                          bottomColor: Colours.color_333),
                      _buildColumn(
                          topStr: '昨日销售额(元)',
                          bottomStr: '40.02',
                          topSize: 12,
                          startBottomSize: 24,
                          endBottomSize: 14,
                          topColor: Colours.color_999,
                          bottomColor: Colours.color_333),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Image.asset(
                          Utils.getImgPath('ic_income_detail'),
                          width: 24,
                          height: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('收益明细',
                              style: new TextStyle(
                                  color: Colours.color_333, fontSize: 16)),
                        ),
                      ],
                    ),
                    trailing: Image.asset(
                      Utils.getImgPath('ic_next_step'),
                      width: 20,
                      height: 20,
                    ),
                    onTap: () => goToIncomeDetail(),
                  ),
                ),
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Image.asset(
                          Utils.getImgPath('ic_rich_people'),
                          width: 24,
                          height: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('富豪榜',
                              style: new TextStyle(
                                  color: Colours.color_333, fontSize: 16)),
                        ),
                      ],
                    ),
                    trailing: Image.asset(
                      Utils.getImgPath('ic_next_step'),
                      width: 20,
                      height: 20,
                    ),
                    onTap: () => goToRichPeople(),
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red,),
                  child: _buildBannerWidget(),
                )
              ],
            )),
      ],
    );
  }

  /// 构造列
  Column _buildColumn(
      {String topStr,
      String bottomStr,
      double topSize,
      double startBottomSize,
      double endBottomSize,
      Color topColor,
      Color bottomColor}) {
    String startBottom;
    String endBottom;
    if (bottomStr.contains('.')) {
      startBottom = bottomStr.substring(0, bottomStr.indexOf('.'));
      endBottom = bottomStr.substring(bottomStr.indexOf('.'));
    } else {
      startBottom = bottomStr;
      endBottom = '';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          topStr,
          style: new TextStyle(color: topColor, fontSize: topSize),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: startBottom,
                  style:
                      TextStyle(fontSize: startBottomSize, color: bottomColor),
                  children: [
                    TextSpan(
                      text: endBottom,
                      style: TextStyle(
                          fontSize: endBottomSize, color: bottomColor),
                    ),
                  ]),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBannerWidget() {
    return Offstage(
      offstage: _bannerList.length == 0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index > _bannerList.length || _bannerList[index] == null) {
            return Container(height: 0);
          } else {
            return InkWell(
              child: new Container(
                margin: EdgeInsets.only(top: 10),
                child: CustomCachedImage(imageUrl: _bannerList[index]),
              ),
              onTap: () {
//                  RouteUtil.toWebView(
//                      context, _bannerList[index].title,
//                      _bannerList[index].url);
              },
            );
          }
        },
        itemCount: _bannerList.length,
        autoplay: true,
        pagination: new SwiperPagination(),
      ),
    );
  }

  /// 跳转到收益详情
  goToIncomeDetail() {
    print('跳转到收益详情');
  }

  /// 跳转到富豪榜
  goToRichPeople() {}

  // 获取首页数据
  void getFirstPageInfo() {
    Future.delayed(Duration(seconds: 2),
        () => {_refreshController.refreshCompleted(resetFooterState: true)});
  }

  Widget itemView(BuildContext context, int index) {
    return addContentView(context);
  }
}
