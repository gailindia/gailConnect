/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

class EmpWishesModel {
  // String empNo,date,inTime,outTime,location;
  double id;
  String sentFrom,
      message,
      sentOn,
      category,
      sentTO,
      SENDER_NAME,
      SENDER_DESIGNATION,
      SENDER_PLACE_OF_POSTING,
      photo;

  EmpWishesModel({
    required this.id,
    required this.sentFrom,
    required this.message,
    required this.sentOn,
    required this.category,
    required this.sentTO,
    required this.SENDER_NAME,
    required this.SENDER_DESIGNATION,
    required this.SENDER_PLACE_OF_POSTING,
    required this.photo,
  });

  factory EmpWishesModel.fromJson(Map<String, dynamic> _dependantJson) =>
      EmpWishesModel(
        id: _dependantJson["ID"],
        sentFrom: _dependantJson["SENT_FROM"],
        message: _dependantJson["MESSAGE"],
        sentOn: _dependantJson["SENT_ON"],
        category: _dependantJson["CATEGORY"],
        sentTO: _dependantJson["SENT_TO"],
        SENDER_NAME: _dependantJson["SENDER_NAME"] == null
            ? ""
            : _dependantJson["SENDER_NAME"],
        SENDER_DESIGNATION: _dependantJson["SENDER_DESIGNATION"] == null
            ? ""
            : _dependantJson["SENDER_DESIGNATION"],
        SENDER_PLACE_OF_POSTING:
            _dependantJson["SENDER_PLACE_OF_POSTING"] == null
                ? ""
                : _dependantJson["SENDER_PLACE_OF_POSTING"],
        photo: _dependantJson["PHOTO"] == null ? "" : _dependantJson["PHOTO"],
      );
}
