class HomeInfoModel {
  String msg;
  int code;
  HomeInfo data;

  HomeInfoModel({this.msg, this.code, this.data});

  HomeInfoModel.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = json['data'] != null ? HomeInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class HomeInfo {
  String todaySalesVolume;
  String monthlyProjectedRevenue;
  String monthlySalesVolume;
  String yesterdaySalesVolume;
  var todayOrderMerchantCount;

  HomeInfo({this.todaySalesVolume, this.monthlyProjectedRevenue, this.monthlySalesVolume, this.yesterdaySalesVolume, this.todayOrderMerchantCount});

  HomeInfo.fromJson(Map<String, dynamic> json) {
    this.todaySalesVolume = json['todaySalesVolume'];
    this.monthlyProjectedRevenue = json['monthlyProjectedRevenue'];
    this.monthlySalesVolume = json['monthlySalesVolume'];
    this.yesterdaySalesVolume = json['yesterdaySalesVolume'];
    this.todayOrderMerchantCount = json['todayOrderMerchantCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todaySalesVolume'] = this.todaySalesVolume;
    data['monthlyProjectedRevenue'] = this.monthlyProjectedRevenue;
    data['monthlySalesVolume'] = this.monthlySalesVolume;
    data['yesterdaySalesVolume'] = this.yesterdaySalesVolume;
    data['todayOrderMerchantCount'] = this.todayOrderMerchantCount;
    return data;
  }
}
