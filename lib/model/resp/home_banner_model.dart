/// bannerId : id
/// photo : "图片地址"
/// htmlUrl : "无效参数"
/// appUrl : "跳转H5地址"

class HomeBanner {
  double bannerId;
  String photo;
  String htmlUrl;
  String appUrl;

  static HomeBanner fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HomeBanner homeBannerBean = HomeBanner();
    homeBannerBean.bannerId = map['bannerId'];
    homeBannerBean.photo = map['photo'];
    homeBannerBean.htmlUrl = map['htmlUrl'];
    homeBannerBean.appUrl = map['appUrl'];
    return homeBannerBean;
  }
}
