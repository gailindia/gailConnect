class SideDrawerElements {
  String activity, screen;
  double id;

  SideDrawerElements({
    required this.id,
    required this.activity,
    required this.screen,
  });

  factory SideDrawerElements.fromJson(Map<String, dynamic> _sideDrawerJson) =>
      SideDrawerElements(
        activity: _sideDrawerJson["ACTIVITY"],
        screen: _sideDrawerJson["MOBILE_ACTIVITY_SCREEN"],
        id: _sideDrawerJson["ID"],
      );
}
// "lstInfo": [
//     {
//       "ID": 1.0,
//       "ACTIVITY": "Cashless Medicine",
//       "MOBILE_ACTIVITY_SCREEN": "/dispensaryDash"
//     },
//     {
//       "ID": 2.0,
//       "ACTIVITY": "Vehicle Search",
//       "MOBILE_ACTIVITY_SCREEN": "/vehiclesearch"
//     }
//   ],
//   "lstInfo2": [],
//   "StatusCode": 200,
//   "Message": "success",