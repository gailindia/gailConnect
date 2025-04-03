// class DispensaryHistoryModel {
//   // double? sno;
//   var empno;
//   //     dependant,
//   //     address,
//   //     mobileNo,
//   //     attachment,
//   //     dateCreated,
//   //     pharmaDoc,
//   //     pharmaUpload;

//   DispensaryHistoryModel({
//     // this.required sno,
//     this.required empno,
//     // this.required dependant,
//     // this.required address,
//     // this.required mobileNo,
//     // this.required attachment,
//     // this.required dateCreated,
//     // this.required pharmaDoc,
//     // this.required pharmaUpload,
//   });

//   factory DispensaryHistoryModel.fromJson(
//           Map<String, dynamic> _dispensaryHistoryJSON) =>
//       DispensaryHistoryModel(
//         // sno: _dispensaryHistoryJSON["SNO"],
//         empno: _dispensaryHistoryJSON["EMPNO"],
//         // dependant: _dispensaryHistoryJSON["DEPENDENT"],
//         // address: _dispensaryHistoryJSON["ADDRESS"],
//         // mobileNo: _dispensaryHistoryJSON["MOBILENO"],
//         // attachment: _dispensaryHistoryJSON["ATTACHMENT"],
//         // dateCreated: _dispensaryHistoryJSON["CREATION_DATE"],
//         // pharmaDoc: _dispensaryHistoryJSON["PHARMACYDOC"],
//         // pharmaUpload: _dispensaryHistoryJSON["PHARMACYUPLOAD"],
//       );
// }


class DispensaryHistoryModel {
  String? empno,
      dependant,
      address,
      mobileNo,
      attachment,
      dateCreated,
      pharmaDoc,
      pharmaUpload,
      sentpharmacy,
      invoiceno,
      invoicedetails,
      voicepdf,
      apolloorderno,
      status,
      acknowledgebyuser,
      acknowledgementremarks,
      invoiceDate,
      cancelleationstatus;


  // store;
  String? sno;
  // address, email, lat, long;
  // double? id;

  DispensaryHistoryModel({
    required this.empno,
    required this.sno,
    required this.dependant,
    required this.address,
    required this.mobileNo,
    required this.attachment,
    required this.dateCreated,
    required this.pharmaDoc,
    required this.pharmaUpload,
    required this.sentpharmacy,
    required this.invoiceno,
    required this.invoicedetails,
    required this.voicepdf,
    required this.apolloorderno,
    required this.status,
    required this.acknowledgebyuser,
    required this.acknowledgementremarks,
    required this.cancelleationstatus,
    required this.invoiceDate,
    // required this.store,
  });

  factory DispensaryHistoryModel.fromJson(
          Map<String, dynamic> _medicalStoreJson) =>
      DispensaryHistoryModel(
        empno: _medicalStoreJson["EMPNO"],
        sno: _medicalStoreJson["SNO"],
        dependant: _medicalStoreJson["DEPENDENT"],
        address: _medicalStoreJson["ADDRESS"],
        mobileNo: _medicalStoreJson["MOBILENO"],
        attachment: _medicalStoreJson["ATTACHMENT"],
        dateCreated: _medicalStoreJson["CREATION_DATE"],
        pharmaDoc: _medicalStoreJson["PHARMACYDOC"],
        pharmaUpload: _medicalStoreJson["PHARMACYUPLOAD"],
        sentpharmacy: _medicalStoreJson["IS_SENT_TO_PHARMACY"],
        invoiceno: _medicalStoreJson["INVOICE_NO"],
        invoiceDate: _medicalStoreJson["INVOICE_DATE"],
        invoicedetails: _medicalStoreJson["INVOICEDETAILS"],
        voicepdf: _medicalStoreJson["INVOICE_PDF"],
        apolloorderno: _medicalStoreJson["APOLLO_ORDERNO"],
        status: _medicalStoreJson["STATUS"],
        acknowledgebyuser: _medicalStoreJson["ACKNOWLEDGE_BY_USER"],
        acknowledgementremarks: _medicalStoreJson["ACKNOWLEDGEMENT_REMARKS"],
        cancelleationstatus: _medicalStoreJson["CANCELLATION_STAUS"]
        // store: _medicalStoreJson["STORE"],
      );
}
