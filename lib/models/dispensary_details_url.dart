class DispensaryHistoryDetailsModelUrl {

  String? url;


  // address, email, lat, long;
  // double? id;

  DispensaryHistoryDetailsModelUrl(
      {required this.url});

  factory DispensaryHistoryDetailsModelUrl.fromJson(
      Map<String, dynamic> _dispensaryHistoryDetailsJson) =>
      DispensaryHistoryDetailsModelUrl(
        url: _dispensaryHistoryDetailsJson["url"],
      );
}
