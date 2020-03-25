class ShopListModel {
  String msg;
  int code;
  List<Shop> data;

  ShopListModel({this.msg, this.code, this.data});

  ShopListModel.fromJson(Map<String, dynamic> json) {    
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = (json['data'] as List)!=null?(json['data'] as List).map((i) => Shop.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    data['data'] = this.data != null?this.data.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class Shop {
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

  Shop({this.shopAddress, this.todaySalesVolume, this.shopName, this.shopImage, this.businessTypeName, this.contactsName, this.mobile, this.distance, this.ifOrder, this.ifSignIn, this.shopId});

  Shop.fromJson(Map<String, dynamic> json) {    
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
