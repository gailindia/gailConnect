class AppStoreModel {
  String? name, android, ios;

  AppStoreModel({
    required this.name,
    required this.android,
    required this.ios,
  });

  factory AppStoreModel.fromJson(Map<String, dynamic> _mynotesJson) =>
      AppStoreModel(
        name: _mynotesJson["NAME"],
        android: _mynotesJson["ANDROID"],
        ios: _mynotesJson["IOS"],
      );
}
