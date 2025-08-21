// Created By Amit Jangid on 23/12/21

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
import 'package:gail_connect/utils/constants/firebase_constants.dart';

class ChatUser {
  String uid;
  String cpf;
  String name;
  String email;
  bool isAdmin;
  String status;
  bool isGroupChat;
  String profileUrl;
  String lastMessage;
  bool isUserSelected;
  String lastMessageBy;
  final lastMessageTime;
  String lastMessageByName;
  String chatRoomOrGroupId;
  String notificationTokenId;

  ChatUser({
    required this.uid,
    required this.cpf,
    required this.name,
    required this.email,
    required this.status,
    required this.isAdmin,
    required this.profileUrl,
    required this.isGroupChat,
    required this.lastMessage,
    required this.lastMessageBy,
    required this.lastMessageTime,
    required this.lastMessageByName,
    required this.chatRoomOrGroupId,
    required this.notificationTokenId,
    this.isUserSelected = false,
  });

  factory ChatUser.fromMap(Map<String, dynamic> _userMap) => ChatUser(
        uid: _userMap[kKeyUid],
        cpf: _userMap[kKeyCpf],
        name: _userMap[kKeyName],
        email: _userMap[kKeyEmail],
        status: _userMap[kKeyStatus],
        isAdmin: _userMap[kKeyIsAdmin],
        profileUrl: _userMap[kKeyProfileUrl],
        isGroupChat: _userMap[kKeyIsGroupChat],
        lastMessage: _userMap[kKeyLastMessage],
        lastMessageBy: _userMap[kKeyLastMessageBy],
        lastMessageByName: _userMap[kKeyLastMessageByName],
        chatRoomOrGroupId: _userMap[kKeyChatRoomOrGroupId],
        notificationTokenId: _userMap[kKeyNotificationTokenId],
        lastMessageTime: _userMap[kKeyLastMessageTime] ?? Timestamp.now(),
      );

  factory ChatUser.fromDoc(DocumentSnapshot? _userDocument) => ChatUser(
        uid: _userDocument![kKeyUid],
        cpf: _userDocument[kKeyCpf],
        name: _userDocument[kKeyName],
        email: _userDocument[kKeyEmail],
        status: _userDocument[kKeyStatus],
        isAdmin: _userDocument[kKeyIsAdmin],
        profileUrl: _userDocument[kKeyProfileUrl],
        isGroupChat: _userDocument[kKeyIsGroupChat],
        lastMessage: _userDocument[kKeyLastMessage],
        lastMessageBy: _userDocument[kKeyLastMessageBy],
        lastMessageByName: _userDocument[kKeyLastMessageByName],
        chatRoomOrGroupId: _userDocument[kKeyChatRoomOrGroupId],
        notificationTokenId: _userDocument[kKeyNotificationTokenId],
        lastMessageTime: _userDocument[kKeyLastMessageTime] ?? Timestamp.now(),
      );

  Map<String, dynamic> toMap() => {
        kKeyUid: uid,
        kKeyCpf: cpf,
        kKeyName: name,
        kKeyEmail: email,
        kKeyStatus: status,
        kKeyIsAdmin: isAdmin,
        kKeyProfileUrl: profileUrl,
        kKeyIsGroupChat: isGroupChat,
        kKeyLastMessage: lastMessage,
        kKeyLastMessageBy: lastMessageBy,
        kKeyLastMessageByName: lastMessageByName,
        kKeyChatRoomOrGroupId: chatRoomOrGroupId,
        kKeyNotificationTokenId: notificationTokenId,
        kKeyLastMessageTime: FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toGroupMap() => {
        kKeyUid: uid,
        kKeyCpf: cpf,
        kKeyName: name,
        kKeyEmail: email,
        kKeyStatus: status,
        kKeyIsAdmin: isAdmin,
        kKeyProfileUrl: profileUrl,
        kKeyIsGroupChat: isGroupChat,
        kKeyLastMessage: lastMessage,
        kKeyLastMessageBy: lastMessageBy,
        kKeyLastMessageByName: lastMessageByName,
        kKeyChatRoomOrGroupId: chatRoomOrGroupId,
        kKeyNotificationTokenId: notificationTokenId,
        kKeyLastMessageTime: Timestamp.now().millisecondsSinceEpoch,
      };

  Map<String, dynamic> toChatListMap(String message) => {
        kKeyLastMessage: message,
        kKeyProfileUrl: profileUrl,
        kKeyLastMessageTime: FieldValue.serverTimestamp(),
        // kKeyLastMessageBy: EmpChatController.to.currentUser!.uid,
        // kKeyLastMessageByName: EmpChatController.to.currentUser!.name,
      };
}
