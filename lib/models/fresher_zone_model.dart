// Created By Amit Jangid 20/10/21


class FresherZoneModel {
  String? module, pathToAccess, link, desc;
  double? sno;

  // "ID": 2.0,
  //     "CONTENT": "gfdb",
  //     "PERIOD_FROM": "2023-01-18T20:00:00",
  //     "PERIOD_TO": "2023-01-20T19:00:00",
  //     "IMAGE": "fd",
  //     "TITLE": "ghg"

  FresherZoneModel(
      {required this.sno,
      required this.module,
      required this.pathToAccess,
      required this.link,
      required this.desc});

  factory FresherZoneModel.fromJson(Map<String, dynamic> _bannerDetailsJson) =>
      FresherZoneModel(
          sno: _bannerDetailsJson["SNO"],
          module: _bannerDetailsJson["MODULE"],
          pathToAccess: _bannerDetailsJson["PATH_TO_ACCESS"],
          link: _bannerDetailsJson["LINK"],
          desc: _bannerDetailsJson["DESCRIPTION"]);
}
