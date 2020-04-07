class ShopSearchListModel {
  String msg;
  int code;
  Data data;

  ShopSearchListModel({this.msg, this.code, this.data});

  ShopSearchListModel.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int next;
  List<SearchShop> records;

  Data({this.next, this.records});

  Data.fromJson(Map<String, dynamic> json) {
    this.next = json['next'];
    this.records = (json['records'] as List) != null
        ? (json['records'] as List).map((i) => SearchShop.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['records'] = this.records != null
        ? this.records.map((i) => i.toJson()).toList()
        : null;
    return data;
  }
}

class SearchShop {
  String shopAddress;
  String todaySalesVolume;
  String shopName;
  String shopImage;
  String businessTypeName;
  String contactsName;
  String mobile;
  String distance;
  bool ifOrder;
  bool ifSignIn;
  int shopId;

  SearchShop(
      {this.shopAddress,
      this.todaySalesVolume,
      this.shopName,
      this.shopImage,
      this.businessTypeName,
      this.contactsName,
      this.mobile,
      this.ifOrder,
      this.shopId,
      this.distance,
      this.ifSignIn});

  SearchShop.fromJson(Map<String, dynamic> json) {
    this.shopAddress = json['shopAddress'];
    this.todaySalesVolume = json['todaySalesVolume'];
    this.shopName = json['shopName'];
    this.shopImage = json['shopImage'];
    this.businessTypeName = json['businessTypeName'];
    this.contactsName = json['contactsName'];
    this.mobile = json['mobile'];
    this.distance = json['distance'];
    this.ifOrder = json['ifOrder'];
    this.ifSignIn = json['ifSignIn'];
    this.shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopAddress'] = this.shopAddress;
    data['todaySalesVolume'] = this.todaySalesVolume;
    data['shopName'] = this.shopName;
    data['shopImage'] = this.shopImage;
    data['businessTypeName'] = this.businessTypeName;
    data['contactsName'] = this.contactsName;
    data['mobile'] = this.mobile;
    data['distance'] = this.distance;
    data['ifOrder'] = this.ifOrder;
    data['ifSignIn'] = this.ifSignIn;
    data['shopId'] = this.shopId;
    return data;
  }
}
