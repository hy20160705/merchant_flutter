import 'package:merchant_flutter/model/resp/base_model.dart';

/// next : -54769713
/// records : [{"shopId":46242345,"shopAddress":"deserunt dolor nostrud proident","todaySalesVolume":"qui","shopName":"non consectetur","shopImage":"sit","businessTypeName":"in ea","contactsName":"c","ifOrder":false,"mobile":"qui eu dolore in"}]
class EnterPriseModel extends BaseModel<EnterpriseList> {

}

class EnterpriseList {
  int next;
  List<Enterprise> records;

  static EnterpriseList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    EnterpriseList enterpriseList = EnterpriseList();
    enterpriseList.next = map['next'];
    enterpriseList.records = List()
      ..addAll(
          (map['records'] as List ?? []).map((o) => Enterprise.fromMap(o)));
    return enterpriseList;
  }
}

/// shopId : 46242345
/// shopAddress : "deserunt dolor nostrud proident"
/// todaySalesVolume : "qui"
/// shopName : "non consectetur"
/// shopImage : "sit"
/// businessTypeName : "in ea"
/// contactsName : "c"
/// ifOrder : false
/// mobile : "qui eu dolore in"

class Enterprise {
  int shopId;
  String shopAddress;
  String todaySalesVolume;
  String shopName;
  String shopImage;
  String businessTypeName;
  String contactsName;
  bool ifOrder;
  String mobile;

  Enterprise(
      {this.shopId,
      this.shopAddress,
      this.todaySalesVolume,
      this.shopName,
      this.shopImage,
      this.businessTypeName,
      this.contactsName,
      this.ifOrder,
      this.mobile});

  static Enterprise fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Enterprise recordsBean = Enterprise();
    recordsBean.shopId = map['shopId'];
    recordsBean.shopAddress = map['shopAddress'];
    recordsBean.todaySalesVolume = map['todaySalesVolume'];
    recordsBean.shopName = map['shopName'];
    recordsBean.shopImage = map['shopImage'];
    recordsBean.businessTypeName = map['businessTypeName'];
    recordsBean.contactsName = map['contactsName'];
    recordsBean.ifOrder = map['ifOrder'];
    recordsBean.mobile = map['mobile'];
    return recordsBean;
  }
}
