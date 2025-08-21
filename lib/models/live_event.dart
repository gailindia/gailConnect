// Created By Amit Jangid 03/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class LiveEvent {
  String? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? navigationLink;
  String? cpfNo;

  LiveEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.navigationLink,
    required this.cpfNo,
  });

  factory LiveEvent.fromJson(Map<String, dynamic> _liveEventJson) => LiveEvent(
        id: _liveEventJson[kJsonId].toString(),
        title: _liveEventJson[kJsonTitle],
        description: _liveEventJson[kJsonDescription],
        startDate: _liveEventJson[kJsonStartDate],
        endDate: _liveEventJson[kJsonEndDate],
        navigationLink: _liveEventJson[kJsonNavigationLink],
        cpfNo: _liveEventJson[kJsonCpfNo],
      );
}
