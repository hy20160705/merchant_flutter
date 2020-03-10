import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:merchant_flutter/model/base_model.dart';
import 'package:merchant_flutter/model/req/login_req.dart';
import 'package:merchant_flutter/model/user_model.dart';
import 'package:merchant_flutter/res/colors.dart';
import 'package:merchant_flutter/net/api/api_service.dart';
import 'package:merchant_flutter/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
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
                                                MainAxisAlignment.center,
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
                                                margin:
                                                    EdgeInsets.only(left: 11.0),
                                                child: Text(
                                                  '获取验证码',
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
    LoginRep loginRep = new LoginRep();
    _showLoading(context);
    apiService.login(loginRep, (BaseModel<UserModel> data) {
      _dismissLoading(context);
      debugPrint(data.toString());
    }, (DioError error) {
      _dismissLoading(context);
      debugPrint(error.toString());
    });
  }

  /// 发送验证码
  void _getVerifyCode() {
    _showLoading(context);
    apiService.getVerifyCode('15751004145', '2', (BaseModel<bool> data) {
      _dismissLoading(context);
      print("getVerifyCode$data");
    }, (DioError error) {
      print('getVerifyCode$error');
      _dismissLoading(context);
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
}
