// Created By Amit Jangid on 31/12/21

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

class ChatNotification {
  String name;
  String appId;
  String message;
  String? imageUrl;
  String? groupName;
  String chatRoomId;
  List<String> tokenIdList;

  ChatNotification({
    required this.name,
    required this.message,
    required this.chatRoomId,
    required this.tokenIdList,
    this.imageUrl,
    this.groupName,
    this.appId = kOneSignalAppId,
  });

  Map<String, dynamic> toMap() => {
    kJsonAppId: appId,
    kJsonThreadId: name,
    kJsonSummaryArg: name,
    kJsonAndroidGroup: name,
    kJsonChatRoomId: chatRoomId,
    kJsonHeadings: {"en": name},
    kJsonContents: {"en": message},
    kJsonIncludePlayerIds: tokenIdList,
  };


  Map<String, dynamic> toImageMap() => {
    kJsonAppId: appId,
    kJsonThreadId: name,
    kJsonSummaryArg: name,
    kJsonAndroidGroup: name,
    kJsonChatRoomId: chatRoomId,
    kJsonHeadings: {"en": name},
    kJsonContents: {"en": kImage},
    kJsonIncludePlayerIds: tokenIdList,
    kJsonBigPicture: imageUrl!,
    kJsonIosAttachments: imageUrl!,
  };

  Map<String, dynamic> toGroupMap() => {
    kJsonAppId: appId,
    kJsonChatRoomId: chatRoomId,
    kJsonThreadId: groupName ?? name,
    kJsonSummaryArg: groupName ?? name,
    kJsonAndroidGroup: groupName ?? name,
    kJsonHeadings: {"en": groupName ?? name},
    kJsonContents: {"en": '$name: $message'},
    kJsonIncludePlayerIds: tokenIdList,
  };

  Map<String, dynamic> toGroupImageMap() => {
    kJsonAppId: appId,
    kJsonChatRoomId: chatRoomId,
    kJsonThreadId: groupName ?? name,
    kJsonSummaryArg: groupName ?? name,
    kJsonAndroidGroup: groupName ?? name,
    kJsonHeadings: {"en": groupName ?? name},
    kJsonContents: {"en": '$name: $kImage'},
    kJsonIncludePlayerIds: tokenIdList,
    kJsonBigPicture: imageUrl!,
    kJsonIosAttachments: imageUrl!,
  };
}
