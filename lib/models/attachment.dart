// Created By Amit Jangid 29/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class Attachment {
  String? fileName;

  Attachment({required this.fileName});

  factory Attachment.fromJson(Map<String, dynamic> _attachmentJson) =>
      Attachment(fileName: _attachmentJson[kJsonFilePath]);
}
