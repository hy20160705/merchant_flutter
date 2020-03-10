/// msg : "ex aliquip"
/// code : "dolor mollit"
/// data : {}

class BaseModel<T> {
  String msg;
  int code;
  T data;

  BaseModel({this.msg, this.code, this.data});

  BaseModel.fromMap(Map<String, dynamic> map) {
    msg = map['msg'];
    code = map['code'];
    data = map['data'];
  }

  @override
  String toString() {
    return 'BaseModel{msg: $msg, code: $code, data: $data}';
  }
}
