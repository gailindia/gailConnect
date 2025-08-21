// Created By Amit Jangid 20/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class BwsDashDetails {
  String? plantCode;
  String? poNumber;
  String? vendorCODE;
  String? receiptNo;
  String? invoiceNo;
  String? invoiceDate;
  double? invoiceAmount;
  String? dateOfEntry;
  String? status;
  String? transDate;
  String? empNo;
  String? empName;

  BwsDashDetails({
    required this.plantCode,
    required this.poNumber,
    required this.vendorCODE,
    required this.receiptNo,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.invoiceAmount,
    required this.dateOfEntry,
    required this.status,
    required this.transDate,
    required this.empNo,
    required this.empName,
  });

  factory BwsDashDetails.fromJson(Map<String, dynamic> _bwsDashDetailsJson) => BwsDashDetails(
        plantCode: _bwsDashDetailsJson[kJsonPlantCode],
        poNumber: _bwsDashDetailsJson[kJsonPoNumber],
        vendorCODE: _bwsDashDetailsJson[kJsonVendorCode],
        receiptNo: _bwsDashDetailsJson[kJsonReceiptNo],
        invoiceNo: _bwsDashDetailsJson[kJsonInvoiceNo],
        invoiceDate: _bwsDashDetailsJson[kJsonInvoiceDate],
        invoiceAmount: _bwsDashDetailsJson[kJsonInvoiceAmount],
        dateOfEntry: _bwsDashDetailsJson[kJsonDateOfEntry],
        status: _bwsDashDetailsJson[kJsonStatus],
        transDate: _bwsDashDetailsJson[kJsonTransDate],
        empNo: _bwsDashDetailsJson[kJsonEmpNo],
        empName: _bwsDashDetailsJson[kJsonEmpName],
      );
}
