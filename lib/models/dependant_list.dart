// // To parse this JSON data, do
// //
// //     final dependantListModel = dependantListModelFromJson(jsonString);

// import 'dart:convert';

// DependantListModel mainDependantModelFromJson(String str) =>
//     DependantListModel.fromJson(json.decode(str));

// String mainDependantModelToJson(DependantListModel data) =>
//     json.encode(data.toJson());

// class DependantListModel {
//   List<LstInfo>? lstInfo;
//   // List<Null>? lstInfo2;
//   int? statusCode;
//   String? message;
//   String? requestId;

//   DependantListModel(
//       {required this.lstInfo,
//       // required this.lstInfo2,
//       required this.statusCode,
//       required this.message,
//       required this.requestId});

//   DependantListModel.fromJson(Map<String, dynamic> json) {
//     if (json['lstInfo'] != null) {
//       lstInfo = <LstInfo>[];
//       json['lstInfo'].forEach((v) {
//         lstInfo?.add(new LstInfo.fromJson(v));
//       });
//     }
//     // if (json['lstInfo2'] != null) {
//     //   lstInfo2 = new List<Null>();
//     //   json['lstInfo2'].forEach((v) {
//     //     lstInfo2.add(new Null.fromJson(v));
//     //   });
//     // }
//     statusCode = json['StatusCode'];
//     message = json['Message'];
//     requestId = json['RequestId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.lstInfo != null) {
//       data['lstInfo'] = this.lstInfo?.map((v) => v.toJson()).toList();
//     }
//     // if (this.lstInfo2 != null) {
//     //   data['lstInfo2'] = this.lstInfo2.map((v) => v.toJson()).toList();
//     // }
//     data['StatusCode'] = this.statusCode;
//     data['Message'] = this.message;
//     data['RequestId'] = this.requestId;
//     return data;
//   }
// }

// class LstInfo {
//   String? eMPNO;
//   String? dEPENDNAME;
//   String? rELATION;
//   String? dOBDEPEND;
//   String? hASHVALUE;
//   String? fLAG;
//   String? uPDATEDONFRSAP;
//   String? pHOTO;
//   String? gENDER;
//   String? dEPENMEDICAL;
//   String? dEPENHOLIDAY;
//   String? dEPENREIMB;
//   String? dEPENEDU;
//   String? cHILDHANDICA;
//   String? oCCUP;
//   String? hOMETOWN;
//   String? hOMETOWNEN;
//   String? hOMETOWNO;
//   String? hOMETOWNENO;

//   LstInfo(
//       {this.eMPNO,
//       this.dEPENDNAME,
//       this.rELATION,
//       this.dOBDEPEND,
//       this.hASHVALUE,
//       this.fLAG,
//       this.uPDATEDONFRSAP,
//       this.pHOTO,
//       this.gENDER,
//       this.dEPENMEDICAL,
//       this.dEPENHOLIDAY,
//       this.dEPENREIMB,
//       this.dEPENEDU,
//       this.cHILDHANDICA,
//       this.oCCUP,
//       this.hOMETOWN,
//       this.hOMETOWNEN,
//       this.hOMETOWNO,
//       this.hOMETOWNENO});

//   LstInfo.fromJson(Map<String, dynamic> json) {
//     eMPNO = json['EMP_NO'];
//     dEPENDNAME = json['DEPEND_NAME'];
//     rELATION = json['RELATION'];
//     dOBDEPEND = json['DOB_DEPEND'];
//     hASHVALUE = json['HASH_VALUE'];
//     fLAG = json['FLAG'];
//     uPDATEDONFRSAP = json['UPDATED_ON_FR_SAP'];
//     pHOTO = json['PHOTO'];
//     gENDER = json['GENDER'];
//     dEPENMEDICAL = json['DEPEN_MEDICAL'];
//     dEPENHOLIDAY = json['DEPEN_HOLIDAY'];
//     dEPENREIMB = json['DEPEN_REIMB'];
//     dEPENEDU = json['DEPEN_EDU'];
//     cHILDHANDICA = json['CHILD_HANDICA'];
//     oCCUP = json['OCCUP'];
//     hOMETOWN = json['HOME_TOWN'];
//     hOMETOWNEN = json['HOME_TOWN_EN'];
//     hOMETOWNO = json['HOME_TOWN_O'];
//     hOMETOWNENO = json['HOME_TOWN_ENO'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['EMP_NO'] = this.eMPNO;
//     data['DEPEND_NAME'] = this.dEPENDNAME;
//     data['RELATION'] = this.rELATION;
//     data['DOB_DEPEND'] = this.dOBDEPEND;
//     data['HASH_VALUE'] = this.hASHVALUE;
//     data['FLAG'] = this.fLAG;
//     data['UPDATED_ON_FR_SAP'] = this.uPDATEDONFRSAP;
//     data['PHOTO'] = this.pHOTO;
//     data['GENDER'] = this.gENDER;
//     data['DEPEN_MEDICAL'] = this.dEPENMEDICAL;
//     data['DEPEN_HOLIDAY'] = this.dEPENHOLIDAY;
//     data['DEPEN_REIMB'] = this.dEPENREIMB;
//     data['DEPEN_EDU'] = this.dEPENEDU;
//     data['CHILD_HANDICA'] = this.cHILDHANDICA;
//     data['OCCUP'] = this.oCCUP;
//     data['HOME_TOWN'] = this.hOMETOWN;
//     data['HOME_TOWN_EN'] = this.hOMETOWNEN;
//     data['HOME_TOWN_O'] = this.hOMETOWNO;
//     data['HOME_TOWN_ENO'] = this.hOMETOWNENO;
//     return data;
//   }
// }

// Created By Amit Jangid on 08/11/21

class DependantListModel {
  String? relation, name, dob, photo;

  DependantListModel(
      {required this.relation,
      required this.name,
      required this.dob,
      required this.photo});

  factory DependantListModel.fromJson(Map<String, dynamic> _dependantJson) =>
      DependantListModel(
        relation: _dependantJson["RELATION"],
        name: _dependantJson["DEPEND_NAME"],
        dob: _dependantJson["DOB_DEPEND"],
        photo: _dependantJson["PHOTO"],
      );
}
