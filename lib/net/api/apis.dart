class Apis {
  static const String BASE_HOST = 'http://m.91mod.net/cx2-test/';

  /// 登录
  static const String LOGIN = 'saler/code/login';

  /// 登出
  static const String LOGIN_OUT = 'public/logout';

  /// 获取手机验证码
  static const String GET_VERIFY_CODE = 'public/mobile/code';

  /// 获取个人用户信息
  static const String GET_USER_INFO = "saler/info";

  /// 获取首页信息（今日下单商户数+今日销售额+获取月预计收益+月累计销售额+昨日销售额）
  static const String GET_FIRST_PAGE_INFO = 'saler/first-page-info/get';

  /// 首页bd招募banner
  static const String ET_BANNER_LIST = "saler/banner/list";
  /// 搜索商户列表
  static const String MY_SHOPS_SEARCH = "saler/my-shops/search";
  /// 获取商户列表（今日下单、未下单）
  static const String MY_SHOPS_LIST = "saler/my-shops/list";
}
