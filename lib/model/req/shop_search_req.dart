class ShopSearchReq {
  /// 门店ID/门店名称
  String shopIdOrName;
  /// 销售员纬度
  String salerLatitude;
  /// 销售员经度
  String salerLongitude;
  /// 排序方式1：综合 2：距离
  int orderBy;
  /// 下一条索引记录位置
  /// 首次查询或第一次查询可以不传，不传将返回第一页数据
  int next;

  ShopSearchReq({this.shopIdOrName, this.salerLatitude, this.salerLongitude, this.orderBy, this.next});

  ShopSearchReq.fromJson(Map<String, dynamic> json) {    
    this.shopIdOrName = json['shopIdOrName'];
    this.salerLatitude = json['salerLatitude'];
    this.salerLongitude = json['salerLongitude'];
    this.orderBy = json['orderBy'];
    this.next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopIdOrName'] = this.shopIdOrName;
    data['salerLatitude'] = this.salerLatitude;
    data['salerLongitude'] = this.salerLongitude;
    data['orderBy'] = this.orderBy;
    data['next'] = this.next;
    return data;
  }

}
