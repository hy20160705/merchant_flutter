/// msg : "ex aliquip"
/// code : "dolor mollit"
/// data : {}

class BaseModel<T> {
  String msg;
  String code;
  T data;
  static BaseModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseModel baseModelBean = BaseModel();
    baseModelBean.msg = map['msg'];
    baseModelBean.code = map['code'];
    baseModelBean.data = map['data'];
    return baseModelBean;
  }
}