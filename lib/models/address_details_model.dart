class AddressDetailsModel{
  String? address,addressDetails,pin;

  AddressDetailsModel({
    required this.address,
    required this.addressDetails,
    required this.pin,

  });

  factory AddressDetailsModel.fromJson(Map<String, dynamic> _dependantJson) =>
      AddressDetailsModel(
        address: _dependantJson["address"],
        addressDetails: _dependantJson["addressDetails"],
        pin: _dependantJson["pin"],

      );


}