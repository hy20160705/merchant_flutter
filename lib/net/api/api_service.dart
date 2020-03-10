import 'package:dio/dio.dart';
import 'package:merchant_flutter/net/api/apis.dart';
import 'package:merchant_flutter/model/home_banner_model.dart';
import 'package:merchant_flutter/net/index.dart';
import 'package:merchant_flutter/model/req/login_req.dart';
import 'package:merchant_flutter/model/base_model.dart';
import 'package:merchant_flutter/model/user_model.dart';

ApiService _apiService = ApiService();

ApiService get apiService => _apiService;

class ApiService {
  

  ///登录
  void login(
      LoginRep loginRep, Function callback, Function errorCallback) async {
    dio.post(Apis.LOGIN, data: loginRep).then((response) {
      callback(BaseModel<UserModel>.fromMap(response.data));
    }).catchError((onError) {
      errorCallback(onError);
    });
  }

  /// 获取手机验证码
  void getVerifyCode(String mobile, String model, Function successCallback,
      Function errorCallback) async {
    var params = {
      'mobile': mobile,
      'model': model,
    };
    FormData data = FormData.fromMap({'mobile': mobile, 'model': model});
    dio.post(Apis.GET_VERIFY_CODE, data: params).then((response) {
      successCallback(BaseModel<bool>.fromMap(response.data));
    }).catchError((onError) {
      errorCallback(onError);
    });
  }

  ///  获取首页数据
  void getBannerList(Function callback, Function errorCallback) async {
    dio.post(Apis.GET_FIRST_PAGE_INFO).then((response) {
      callback(HomeBanner.fromMap(response.data));
    }).catchError((onError) {
      errorCallback(onError);
    });
  }
}
