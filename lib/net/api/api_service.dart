import 'package:dio/dio.dart';
import 'package:merchant_flutter/model/req/shop_req.dart';
import 'package:merchant_flutter/model/req/shop_search_req.dart';
import 'package:merchant_flutter/model/resp/shop_list_model.dart';
import 'package:merchant_flutter/model/resp/shop_search_list_model.dart';
import 'package:merchant_flutter/net/api/apis.dart';
import 'package:merchant_flutter/model/resp/home_info_model.dart';
import 'package:merchant_flutter/net/index.dart';
import 'package:merchant_flutter/model/req/login_req.dart';
import 'package:merchant_flutter/model/resp/base_model.dart';
import 'package:merchant_flutter/model/resp/user_model.dart';

ApiService _apiService = ApiService();

ApiService get apiService => _apiService;

class ApiService {
  ///登录
  void login(
      LoginRep loginRep, Function callback, Function errorCallback) async {
    FormData data = FormData.fromMap(loginRep.toJson());
    dio.post(Apis.LOGIN, data: data).then((response) {
      callback(BaseModel<String>.fromMap(response.data));
    }).catchError((onError) {
      errorCallback(onError);
    });
  }

  /// 获取手机验证码
  void getVerifyCode(String mobile, String module, Function successCallback,
      Function errorCallback) async {
    var params = {
      'mobile': mobile,
      'module': module,
    };
    dio.post(Apis.GET_VERIFY_CODE, data: params).then((response) {
      successCallback(BaseModel<bool>.fromMap(response.data));
    }).catchError((onError) {
      errorCallback(onError);
    });
  }

  /// 获取用户信息
  void getUserInfo(Function onSuccess, Function onFailed) async {
    dio.post(Apis.GET_USER_INFO).then((response) {
      onSuccess(UserModel.fromJson(response.data));
    }).catchError((error) {
      onFailed(error);
    });
  }

  ///  获取首页数据
  void getHomeInfo(Function onSuccess, Function onFailed) async {
    dio.post(Apis.GET_FIRST_PAGE_INFO).then((response) {
      onSuccess(HomeInfoModel.fromJson(response.data));
    }).catchError((onError) {
      onFailed(onError);
    });
  }

  ///  搜索商户列表（全部、ID\名称）
  void getMyShopsBySearch(
      ShopSearchReq req, Function onSuccess, Function onFailed) async {
    dio.post(Apis.MY_SHOPS_SEARCH, data: req).then((response) {
      onSuccess(ShopSearchListModel.fromJson(response.data));
    }).catchError((onError) {
      onFailed(onError);
    });
  }

  ///  获取商户列表（今日下单、未下单）
  void getMyShops(ShopReq req, Function onSuccess, Function onFailed) async {
    dio.post(Apis.MY_SHOPS_LIST, data: req).then((response) {
      onSuccess(ShopListModel.fromJson(response.data));
    }).catchError((onError) {
      onFailed(onError);
    });
  }
}
