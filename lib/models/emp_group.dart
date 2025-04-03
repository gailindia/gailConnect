// Created By Amit Jangid on 20/12/21

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class EmpGroup {
  String id;
  String groupName;
  String groupIcon;
  String createdByCpf;
  String createdByName;
  String createDate;
  String? groupMembers;

  EmpGroup({
    required this.id,
    required this.groupName,
    required this.groupIcon,
    required this.createdByCpf,
    required this.createdByName,
    required this.createDate,
    required this.groupMembers,
  });

  factory EmpGroup.fromJson(Map<String, dynamic> _empGroupJson) {
    return EmpGroup(
      id: _empGroupJson[kJsonIdCaps].toString(),
      groupName: _empGroupJson[kJsonGroupName] ?? kGroupName,
      groupIcon: _empGroupJson[kJsonGroupIcon] ?? '',
      createdByCpf: _empGroupJson[kJsonCreatedByCpfFullCaps] ?? _empGroupJson[kJsonCreatedByCpf],
      createdByName: _empGroupJson[kJsonCreatedByNameFullCaps] ?? _empGroupJson[kJsonCreatedByName],
      createDate: _empGroupJson[kJsonCreateDateFullCaps] ?? _empGroupJson[kJsonCreateDate],
      groupMembers: _empGroupJson[kJsonGroupMembers],
    );
  }
}
