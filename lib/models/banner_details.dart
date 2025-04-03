// Created By Amit Jangid 20/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class BannerDetails {
  String? id;
  String? image;
  String? imageSerial;

  BannerDetails({required this.id, required this.image, required this.imageSerial});

  factory BannerDetails.fromJson(Map<String, dynamic> _bannerDetailsJson) => BannerDetails(
        id: _bannerDetailsJson[kJsonIdCaps].toString(),
        image: _bannerDetailsJson[kJsonImage],
        imageSerial: _bannerDetailsJson[kJsonImageSerial],
      );
}
