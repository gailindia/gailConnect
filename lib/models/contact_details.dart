class ContactDetailsModel {
  String? mobileNo, address;
  ContactDetailsModel({
    required this.mobileNo,
    required this.address,
  });

  factory ContactDetailsModel.fromJson(Map<String, dynamic> _mobileNoJson) =>
      ContactDetailsModel(
        mobileNo: _mobileNoJson["TELEPHONE_NO"],
        address: _mobileNoJson["ADDRESS"],
      );
}
