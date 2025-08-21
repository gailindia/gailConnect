// Created By Amit Jangid on 27/12/21

import 'package:gail_connect/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gail_connect/utils/constants/firebase_constants.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';

class EmpGroupInfo {
  String groupId;
  String groupName;
  String groupIcon;
  String createdBy;
  String lastMessage;
  String createdByName;
  String lastMessageBy;
  final createDate;
  String lastMessageByName;
  final lastMessageTime;
  List<ChatUser> groupMembersList;
  List<Map<String, dynamic>> membersMapList;

  EmpGroupInfo({
    required this.groupId,
    required this.groupName,
    required this.groupIcon,
    required this.createdBy,
    required this.createDate,
    required this.lastMessage,
    required this.createdByName,
    required this.lastMessageBy,
    required this.lastMessageTime,
    required this.lastMessageByName,
    required this.membersMapList,
    this.groupMembersList = const <ChatUser>[],
  });

  factory EmpGroupInfo.fromMap(Map<String, dynamic> _groupInfoMap) =>
      EmpGroupInfo(
        membersMapList: [],
        groupId: _groupInfoMap[kKeyGroupId],
        groupName: _groupInfoMap[kKeyGroupName],
        groupIcon: _groupInfoMap[kKeyGroupIcon],
        lastMessage: _groupInfoMap[kKeyLastMessage],
        createdBy: _groupInfoMap[kKeyGroupCreatedBy],
        lastMessageBy: _groupInfoMap[kKeyLastMessageBy],
        createdByName: _groupInfoMap[kKeyGroupCreatedByName],
        lastMessageByName: _groupInfoMap[kKeyLastMessageByName],
        createDate: _groupInfoMap[kKeyGroupCreateDate] ?? Timestamp.now(),
        lastMessageTime: _groupInfoMap[kKeyLastMessageTime] ?? Timestamp.now(),
        groupMembersList: _groupInfoMap[kKeyMembers]
                ?.map<ChatUser>((_userMap) => ChatUser.fromMap(_userMap))
                ?.toList() ??
            [],
      );

  factory EmpGroupInfo.fromDoc(DocumentSnapshot? _groupDoc) => EmpGroupInfo(
        groupId: _groupDoc![kKeyGroupId],
        groupName: _groupDoc[kKeyGroupName],
        groupIcon: _groupDoc[kKeyGroupIcon],
        lastMessage: _groupDoc[kKeyLastMessage],
        createdBy: _groupDoc[kKeyGroupCreatedBy],
        lastMessageBy: _groupDoc[kKeyLastMessageBy],
        createdByName: _groupDoc[kKeyGroupCreatedByName],
        lastMessageByName: _groupDoc[kKeyLastMessageByName],
        createDate: _groupDoc[kKeyGroupCreateDate] ?? Timestamp.now(),
        lastMessageTime: _groupDoc[kKeyLastMessageTime] ?? Timestamp.now(),
        membersMapList: [],
        groupMembersList: _groupDoc[kKeyMembers]
                ?.map<ChatUser>((_userMap) => ChatUser.fromMap(_userMap))
                ?.toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
        kKeyGroupId: groupId,
        kKeyGroupName: groupName,
        kKeyGroupIcon: groupIcon,
        kKeyMembers: membersMapList,
        kKeyLastMessage: lastMessage,
        kKeyGroupCreatedBy: createdBy,
        kKeyLastMessageBy: lastMessageBy,
        kKeyGroupCreatedByName: createdByName,
        kKeyLastMessageByName: lastMessageByName,
        kKeyGroupCreateDate: Timestamp.now().millisecondsSinceEpoch,
        kKeyLastMessageTime: Timestamp.now().millisecondsSinceEpoch,
      };

  Map<String, dynamic> toGroupInfoUpdateMap({required String message}) => {
        kKeyGroupName: groupName,
        kKeyGroupIcon: groupIcon,
        kKeyLastMessage: message,
        kKeyLastMessageTime: FieldValue.serverTimestamp(),
        // kKeyLastMessageBy: EmpChatController.to.currentUser!.uid,
        // kKeyLastMessageByName: EmpChatController.to.currentUser!.name,
      };

  Map<String, dynamic> toChatListMap(String _message) => {
        kKeyLastMessage: _message,
        kKeyLastMessageTime: FieldValue.serverTimestamp(),
        // kKeyLastMessageBy: EmpChatController.to.currentUser!.uid,
        // kKeyLastMessageByName: EmpChatController.to.currentUser!.name,
      };
}
