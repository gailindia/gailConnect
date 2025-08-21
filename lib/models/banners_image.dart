import 'package:gail_connect/utils/constants/http_constants.dart';

class BannersImage {
  String? serialNo;
  String? bannerTitle;
  String? image;
  String? fromDate;
  String? toDate;
  String? link;

  BannersImage(
      {required this.serialNo,
      required this.bannerTitle,
      required this.image,
      required this.fromDate,
      required this.toDate,
      required this.link});

  factory BannersImage.fromJson(Map<String, dynamic> _bannerJson) =>
      BannersImage(
          serialNo: _bannerJson[kJsonSerialNo].toString(),
          bannerTitle: _bannerJson[kJsonBannerTitle],
          image: _bannerJson[kJsonImage],
          fromDate: _bannerJson[kJsonFromDate_],
          toDate: _bannerJson[kJsonToDate_],
          link: _bannerJson["ACCESSLINK"]);
}
