class DispensaryHistoryDetailsModel {
  String? sno;
  String? empno,
      dependent,
      address,
      mobileno,
      attachment,
      creationDate,
      store,
      pharmacydoc,
      pharmacyupload,
      deliverymode,
      pharmacystore,
      pin,
      remarks,
      isSentToPharmacy,
      sentToPharmacyOn,
      apolloOrderno,
      invoiceNo,
      invoiceAmt;

  // address, email, lat, long;
  // double? id;

  DispensaryHistoryDetailsModel(
      {required this.sno,
      required this.empno,
      required this.dependent,
      required this.address,
      required this.mobileno,
      required this.attachment,
      required this.creationDate,
      required this.store,
      required this.pharmacydoc,
      required this.pharmacyupload,
      required this.deliverymode,
      required this.pharmacystore,
      required this.pin,
      required this.remarks,
      required this.isSentToPharmacy,
      required this.sentToPharmacyOn,
      required this.apolloOrderno,
      required this.invoiceNo,
      required this.invoiceAmt});

  factory DispensaryHistoryDetailsModel.fromJson(
          Map<String, dynamic> _dispensaryHistoryDetailsJson) =>
      DispensaryHistoryDetailsModel(
        sno: _dispensaryHistoryDetailsJson["SNO"],
        empno: _dispensaryHistoryDetailsJson["EMPNO"],
        dependent: _dispensaryHistoryDetailsJson["DEPENDENT"],
        address: _dispensaryHistoryDetailsJson["ADDRESS"],
        mobileno: _dispensaryHistoryDetailsJson["MOBILENO"],
        attachment: _dispensaryHistoryDetailsJson["ATTACHMENT"],
        creationDate: _dispensaryHistoryDetailsJson["CREATION_DATE"],
        store: _dispensaryHistoryDetailsJson["STORE"],
        pharmacydoc: _dispensaryHistoryDetailsJson["PHARMACYDOC"],
        pharmacyupload: _dispensaryHistoryDetailsJson["PHARMACYUPLOAD"],
        deliverymode: _dispensaryHistoryDetailsJson["DELIVERYMODE"],
        pharmacystore: _dispensaryHistoryDetailsJson["PHARMACYSTORE"],
        pin: _dispensaryHistoryDetailsJson["PIN"],
        remarks: _dispensaryHistoryDetailsJson["REMARKS"],
        isSentToPharmacy: _dispensaryHistoryDetailsJson["IS_SENT_TO_PHARMACY"],
        sentToPharmacyOn: _dispensaryHistoryDetailsJson["SENT_TO_PHARMACY_ON"],
        apolloOrderno: _dispensaryHistoryDetailsJson["APOLLO_ORDERNO"],
        invoiceNo: _dispensaryHistoryDetailsJson["INVOICE_NO"],
        invoiceAmt: _dispensaryHistoryDetailsJson["INVOICE_AMOUNT"],
      );
}
