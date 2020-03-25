import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:merchant_flutter/common/common.dart';
import 'package:merchant_flutter/common/router_config.dart';
import 'package:merchant_flutter/common/user.dart';
import 'package:merchant_flutter/main.dart';
import 'package:merchant_flutter/utils/index.dart';
import 'package:merchant_flutter/utils/toast_util.dart';

import '../index.dart';

/// WanAndroid 统一接口返回格式错误检测
class WanAndroidErrorInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    String token=SPUtil.getString(Constants.TOKEN_KEY);
    if(token.isNotEmpty){
      options.headers['token']=token;
    }
    return options;
  }

  @override
  onError(DioError error) async {
    String errorMsg = DioManager.handleError(error);
    T.show(msg: errorMsg);
    return error;
  }

  @override
  onResponse(Response response) async {
    var data = response.data;

    if (data is String) {
      data = json.decode(data);
    }
    if (data is Map) {
      var code = data['code'] ??
          Constants.STATUS_SUCCESS; // 表示如果data['errorCode']为空的话把 0赋值给errorCode
      String errorMsg = data['msg'] ?? '请求失败[$code]';
      if (code == Constants.STATUS_SUCCESS||code==Constants.STATUS_SUCCESS.toString()) {
        // 正常
        return response;
      } else if (code == Constants.UN_LOGIN||code==Constants.UN_LOGIN.toString() /*未登录错误码*/) {
        User().clearUserInfo();
        dio.clear(); // 调用拦截器的clear()方法来清空等待队列。
        SPUtil.clear();
        goLogin();
        return dio.reject(errorMsg); // 完成和终止请求/响应
      } else {
        T.show(msg: errorMsg);
        return dio.reject(errorMsg); // 完成和终止请求/响应
      }
    }

    return response;
  }

  void goLogin() {
    /// 在拿不到context的地方通过navigatorKey进行路由跳转：
    /// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
    navigatorKey.currentState.pushNamed(RouterName.login);
  }
}
