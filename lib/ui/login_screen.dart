import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/common/router_config.dart';
import 'package:merchant_flutter/model/base_model.dart';
import 'package:merchant_flutter/model/req/login_req.dart';
import 'package:merchant_flutter/model/user_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/net/api/api_service.dart';
import 'package:merchant_flutter/utils/index.dart';
import 'package:merchant_flutter/utils/toast_util.dart';
import 'package:merchant_flutter/widgets/loading_dialog.dart';
import 'package:package_info/package_info.dart';

import 'package:merchant_flutter/ui/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  String token = SPUtil.getString(Constants.TOKEN_KEY);
  TextEditingController _codeController = TextEditingController();
  AndroidDeviceInfo _androidInfo;
  IosDeviceInfo _iosInfo;
  PackageInfo _packageInfo;
  Timer _timer;
  int _countdownTime = 60;
  String _sendCodeTip = '获取验证码';

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colours.color_3F4251,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 63.0),
              child: Text("菜小二销售端",
                  style: TextStyle(color: Colors.white, fontSize: 29.0)),
            ),
            Card(
              color: Colors.white,
              elevation: 0.0,
              margin: EdgeInsets.only(left: 35.0, top: 43.0, right: 35.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: SizedBox(
                  height: 300.0,
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text(
                            '登录',
                            style: TextStyle(
                                color: Colours.color_333, fontSize: 24.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(27.0, 20.0, 27.0, 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _userNameController,
                            style: TextStyle(
                                color: Colours.color_333, fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: '请输入手机号',
                              hintStyle: TextStyle(color: Colours.color_ccc),
                              fillColor: Colours.color_f7f7f7,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 11.0),
                              labelStyle: TextStyle(
                                  color: Colours.color_ccc, fontSize: 16.0),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colours.color_f7f7f7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colours.color_f7f7f7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colours.color_f7f7f7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(27.0, 0.0, 27.0, 20.0),
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _codeController,
                                style: TextStyle(
                                    color: Colours.color_333, fontSize: 16.0),
                                decoration: InputDecoration(
                                    hintText: '请输入验证码',
                                    hintStyle:
                                        TextStyle(color: Colours.color_ccc),
                                    fillColor: Colours.color_f7f7f7,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 11.0, right: 11.0),
                                    labelStyle: TextStyle(
                                        color: Colours.color_ccc,
                                        fontSize: 16.0),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colours.color_f7f7f7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colours.color_f7f7f7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colours.color_f7f7f7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    suffix: SizedBox(
                                        width: 94.0,
                                        child: InkWell(
                                          onTap: () {
                                            _getVerifyCode();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 1,
                                                height: 15.0,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: Colours.color_ccc,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    EdgeInsets.only(left: 11.0),
                                                child: Text(
                                                  _sendCodeTip,
                                                  style: TextStyle(
                                                      color:
                                                          Colours.color_FF714A,
                                                      fontSize: 14.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ))))),
                        Container(
                          height: 40.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 27.0, right: 27.0),
                          child: MaterialButton(
                              color: Colours.color_FF714A,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Text(
                                "登陆",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              onPressed: _login),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: RichText(
                            text: TextSpan(
                                text: '点击登录表示您同意',
                                style: TextStyle(
                                    color: Colours.color_333, fontSize: 12.0),
                                children: [
                                  TextSpan(
                                      text: '《菜小二服务协议》',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colours.color_3781CA),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('《菜小二服务协议》点击');
                                        })
                                ]),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  /// 登录
  void _login() {
    if (!_loginValidate()) {
      return;
    }
    LoginRep loginRep = new LoginRep();
    loginRep.username = _userNameController.text;
    loginRep.password = _codeController.text;
    // 后面再补充 TODO
    if (Platform.isAndroid) {
      loginRep.deviceType = '2';
      loginRep.deviceToken = _androidInfo.androidId;
      loginRep.hostSerial = _androidInfo.host;
    } else if (Platform.isIOS) {
      loginRep.deviceType = '1';
      loginRep.deviceToken = '';
    }
    loginRep.deviceVersion = _packageInfo.version;

    _showLoading(context);
    apiService.login(loginRep, (BaseModel<String> data) async {
      SPUtil.putString(Constants.TOKEN_KEY, data.data);
      _getUserInfo();
    }, (DioError error) {
      _dismissLoading(context);
      debugPrint(error.toString());
      T.show(msg: error.message);
    });
  }

  _getUserInfo() {
    apiService.getUserInfo((UserModel data) {
      _dismissLoading(context);
      SPUtil.putObject(Constants.USER_INFO_KEY, data.data);
      Navigator.pushNamed(context, RouterName.main);
    }, (DioError error) {
      _dismissLoading(context);
      T.show(msg: error.message);
    });
  }

  /// 发送验证码
  void _getVerifyCode() {
    if (_countdownTime != 60) {
      return;
    }
    if (!_validateMobile(_userNameController.text)) {
      T.show(msg: '手机号格式不正确', toastLength: Toast.LENGTH_SHORT);
      return;
    }

    _showLoading(context);
    apiService.getVerifyCode(_userNameController.text, '2',
        (BaseModel<bool> data) {
      _dismissLoading(context);
      print("getVerifyCode$data");
      const oneSec = const Duration(seconds: 1);
      var calBack = (timer) => {
            setState(() {
              if (_countdownTime < 1) {
                _timer.cancel();
                _sendCodeTip = '获取验证码';
                _countdownTime = 60;
              } else {
                _countdownTime = _countdownTime - 1;
                _sendCodeTip = '$_countdownTime' + 's';
              }
            })
          };
      _timer = Timer.periodic(oneSec, calBack);
    }, (DioError error) {
      print('getVerifyCode$error');
      _dismissLoading(context);
      setState(() {
        _sendCodeTip = '获取验证码';
      });
    });
  }

  /// 显示Loading
  _showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingDialog(
            outsideDismiss: false,
            loadingText: "正在登陆...",
          );
        });
  }

  /// 隐藏Loading
  _dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  /// 校验手机号
  bool _validateMobile(String mobile) {
    return RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(mobile);
  }

  /// 登录校验
  bool _loginValidate() {
    if (_userNameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('请输入手机号')));
      return false;
    }
    if (!_validateMobile(_userNameController.text)) {
      T.show(msg: '手机号格式不正确', toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    if (_codeController.text.isEmpty) {
      T.show(msg: '请输入验证码', toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    return true;
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    _androidInfo = await deviceInfo.androidInfo;
//    _iosInfo = await deviceInfo.iosInfo;
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
