// Created By Amit Jangid 26/08/21

import 'package:gail_connect/main.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiutillib/utils/date_time_extension.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:url_launcher/url_launcher.dart';

String getImageUrl(String? _imageUrl) {
  if (_imageUrl != null && _imageUrl.isNotEmpty) {
    if (_imageUrl.toLowerCase().contains('https')) {
      return _imageUrl;
    } else {
      return '$kImageUrl$_imageUrl';
    }
  }

  return '';
}

trimLeadingZeros(String value) => int.parse(value).toString();

Future<bool> checkConnectivity() async {
  try {
    final _connectivityResult = await Connectivity().checkConnectivity();

    if (_connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (_connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  } catch (e, s) {
    handleException(
      exception: e,
      stackTrace: s,
      exceptionClass: 'utils',
      exceptionMsg: 'exception while checking for connectivity',
    );

    return false;
  }
}

//launch("tel://21213123123")
launchDialer(String number) async {
  String url = 'tel:' + number;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Application unable to open dialer.';
  }
}

String convertMillisecondsToDate(int milliseconds) {
  final DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

  return _dateTime.formatDateTime(newDateTimeFormat: 'dd/MM/yyyy');
}

String convertTimeStampToDate(Timestamp timestamp, {String? newDateFormat}) {
  final DateTime _dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

  return _dateTime.formatDateTime(
      newDateTimeFormat: newDateFormat ?? 'dd/MM/yyyy');
}

String convertTimeStampToTime(Timestamp timestamp) {
  final DateTime _dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

  return _dateTime.formatDateTime(newDateTimeFormat: 'hh:mm a');
}
