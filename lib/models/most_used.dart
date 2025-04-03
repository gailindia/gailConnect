class MostUsedLinksModel {
  String? activity, appcode, screen;
  double? hits;

  MostUsedLinksModel({
    required this.activity,
    required this.appcode,
    required this.hits,
    required this.screen,
  });

  factory MostUsedLinksModel.fromJson(Map<String, dynamic> _dependantJson) =>
      MostUsedLinksModel(
        activity: _dependantJson["ACTIVITY"],
        appcode: _dependantJson["APP_CODE"],
        hits: _dependantJson["TOTALHITS"],
        screen: _dependantJson["MOBILE_ACTIVITY_SCREEN"],
      );
}


  // "dtEvents": [
  //   {
  //     "ACTIVITY": "BIS Helpdesk Calls Screen",
  //     "APP_CODE": "CNTP",
  //     "TOTALHITS": 1599.0
  //   },