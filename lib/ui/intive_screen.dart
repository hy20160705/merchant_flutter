import 'package:flutter/material.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/model/resp/user_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/utils/index.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InviteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InviteScreenState();
  }
}

class InviteScreenState extends State<InviteScreen> {
  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    debugPrint('_userInfo=>${SPUtil.getObject(Constants.USER_INFO_KEY)}');
    _userInfo = UserInfo.fromJson(SPUtil.getObject(Constants.USER_INFO_KEY));
    debugPrint('_userInfo=>${_userInfo.toString}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colours.color_3F4251,
        child: Card(
          color: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Image.asset(Utils.getImgPath('invite_logo'),
                    width: 237.0, height: 176.0),
              ),
              QrImage(
                data: _userInfo.inviteCode,
                version: 3,
                size: 240,
                gapless: true,
              ),
//              Image.asset(Utils.getImgPath('invite_logo')),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  '我的二维码：${_userInfo.inviteCode.substring(_userInfo.inviteCode.indexOf('-')+1)}',
                  style: TextStyle(color: Colours.color_999, fontSize: 18.0),
                ),
              )
            ],
          ),
        ));
  }
}
