
import 'package:flutter/material.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/common/router_config.dart';
import 'package:merchant_flutter/model/resp/user_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/index.dart';
import 'package:merchant_flutter/utils/route_util.dart';
import 'package:merchant_flutter/utils/toast_util.dart';
import 'package:merchant_flutter/widgets/image_view.dart';

class MineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MineScreenState();
  }
}

class MineScreenState extends State<MineScreen> {
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    _userInfo = UserInfo.fromJson(SPUtil.getObject(Constants.USER_INFO_KEY));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colours.color_f7f7f7,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                    child: Image.asset(Utils.getImgPath('ic_mine_head'))),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: Text(
                            _userInfo.salerName,
                            style:
                                TextStyle(color: Colors.white, fontSize: 40.0),
                          )),
                      Container(
                        margin: EdgeInsets.only(right: 30.0),
                        child: ImageWidget(
                          url: _userInfo.photoPath ?? '',
                          w: 60.0,
                          h: 60.0,
                          defImagePath:
                              Utils.getImgPath('ic_mine_head_default'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Card(
              elevation: 0.0,
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '清除缓存',
                      style:
                          TextStyle(color: Colours.color_333, fontSize: 16.0),
                    ),
                    trailing: Image.asset(
                      Utils.getImgPath('ic_next_step'),
                      width: 20,
                      height: 20,
                    ),
                    onTap: () => _clearMemory(),
                  ),
                  ListTile(
                      title: Text(
                        '版本信息',
                        style:
                            TextStyle(color: Colours.color_333, fontSize: 16.0),
                      ),
                      trailing: Text(
                        'V1.0.0',
                        style: TextStyle(
                            color: Colours.color_93989E, fontSize: 16.0),
                      )),
                ],
              ),
            ),
            Container(
              height: 50.0,
              width: double.infinity,
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: MaterialButton(
                  elevation: 0,
                  color: Colours.color_white,
                  textColor: Colours.color_FF714A,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                    "退出登录",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: _loginOut),
            ),
          ],
        ));
  }

  /// 清除缓存
  _clearMemory() {
    T.show(msg: '清除缓存');
  }

  /// 退出登录
  void _loginOut() {
    T.show(msg: '退出登录');
    SPUtil.clear();
    Navigator.of(context).pushNamed(RouterName.login);
//    SPUtil.clear();
  }
}
