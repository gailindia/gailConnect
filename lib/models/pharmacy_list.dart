// class MedicalStoreList {
//   String? name, address, email, lat, long;
//   double? id;

//   MedicalStoreList({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.lat,
//     required this.long,
//     required this.email,
//   });

//   factory MedicalStoreList.fromJson(Map<String, dynamic> _medicalStoreJson) =>
//       MedicalStoreList(
//         id: _medicalStoreJson["STORE_ID"],
//         name: _medicalStoreJson["STORE_NAME"],
//         address: _medicalStoreJson["ADDRESS"],
//         lat: _medicalStoreJson["LATITUDE"],
//         long: _medicalStoreJson["LONGITUDE"],
//         email: _medicalStoreJson["EMAIL"],
//       );
// }

class PharmacyList {
  String? pharmacyName;
  PharmacyList({
    required this.pharmacyName,
  });

  factory PharmacyList.fromJson(Map<String, dynamic> _medicalStoreJson) =>
      PharmacyList(
        pharmacyName: _medicalStoreJson["PHARACY_STORE"],
      );
}
