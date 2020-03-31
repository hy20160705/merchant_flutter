class ShopReq {
  /// 销售员纬度
  String salerLatitude;

  /// 销售员经度
  String salerLongitude;

  /// 订单状态 1：今日未下单  2：今日已下单 其它：全部
  int status;

  /// 排序方式1：综合   2：距离
  int orderBy;

  int next;

  ShopReq({this.salerLatitude, this.salerLongitude, this.status, this.orderBy,this.next});

  ShopReq.fromJson(Map<String, dynamic> json) {
    this.salerLatitude = json['salerLatitude'];
    this.salerLongitude = json['salerLongitude'];
    this.status = json['status'];
    this.orderBy = json['orderBy'];
    this.next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salerLatitude'] = this.salerLatitude;
    data['salerLongitude'] = this.salerLongitude;
    data['status'] = this.status;
    data['orderBy'] = this.orderBy;
    data['next'] = this.next;
    return data;
  }
}
