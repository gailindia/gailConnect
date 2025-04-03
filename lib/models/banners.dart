// Created By Amit Jangid 20/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Banners {
  String? serialNo;
  String? bannerTitle;
  String? image;
  String? fromDate;
  String? toDate;
  String? linkType;
  String? linkURL;

  Banners({
    this.serialNo,
    required this.bannerTitle,
    required this.image,
    required this.fromDate,
    required this.toDate,
    required this.linkType,
    required this.linkURL,
  });

  factory Banners.fromJson(Map<String, dynamic> _bannerJson) => Banners(
        serialNo: _bannerJson[kJsonSerialNo].toString(),
        bannerTitle: _bannerJson[kJsonBannerTitle],
        image: _bannerJson[kJsonImage],
        fromDate: _bannerJson[kJsonFromDate_],
        toDate: _bannerJson[kJsonToDate_],
        linkType: _bannerJson["LINK_TYPE"],
        linkURL: _bannerJson["LINK_URL"],
      );

  // "SERIALNO": 1.0,
// "BANNERTITLE": "Diwali",
// "IMAGE": "E-32.png",
// "FROM_DATE": "20/10/2022",
// "TO_DATE": "30/10/2022",
// "LINK_TYPE": "FEST",
// "LINK_URL": null
}
