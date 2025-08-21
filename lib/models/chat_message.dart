// Created By Amit Jangid on 24/12/21

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gail_connect/utils/constants/firebase_constants.dart';

class ChatMessage {
  int msgType;
  bool isAdmin;
  bool msgSeen;
  String fromUid;
  String message;
  String fromName;
  Timestamp timestamp;
  Timestamp? msgSeenTime;

  ChatMessage({
    this.msgSeenTime,
    this.fromName = '',
    this.isAdmin = false,
    required this.msgSeen,
    required this.fromUid,
    required this.message,
    required this.msgType,
    required this.timestamp,
  });

  factory ChatMessage.fromDoc(DocumentSnapshot? _chatMsgDoc) => ChatMessage(
        msgSeen: _chatMsgDoc?[kKeyMsgSeen],
        fromUid: _chatMsgDoc?[kKeyFromUid],
        message: _chatMsgDoc?[kKeyMessage],
        msgType: _chatMsgDoc?[kKeyMsgType],
        msgSeenTime: _chatMsgDoc?[kKeyMsgSeenTime],
        timestamp: _chatMsgDoc?[kKeyTimeStamp] ?? Timestamp.now(),
      );

  factory ChatMessage.fromGroupDoc(DocumentSnapshot? _chatMsgDoc) => ChatMessage(
        fromName: _chatMsgDoc?[kKeyName],
        message: _chatMsgDoc?[kKeyMessage],
        msgType: _chatMsgDoc?[kKeyMsgType],
        msgSeen: _chatMsgDoc?[kKeyMsgSeen],
        isAdmin: _chatMsgDoc?[kKeyIsAdmin],
        fromUid: _chatMsgDoc?[kKeyFromUid],
        msgSeenTime: _chatMsgDoc?[kKeyMsgSeenTime],
        timestamp: _chatMsgDoc?[kKeyTimeStamp] ?? Timestamp.now(),
      );

  Map<String, dynamic> toMap() => {
        kKeyMsgSeen: msgSeen,
        kKeyFromUid: fromUid,
        kKeyMessage: message,
        kKeyMsgType: msgType,
        kKeyMsgSeenTime: msgSeenTime,
        kKeyTimeStamp: FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toMsgSeenMap() => {kKeyMsgSeen: true, kKeyMsgSeenTime: FieldValue.serverTimestamp()};

  Map<String, dynamic> toGroupMap() => {
        kKeyName: fromName,
        kKeyIsAdmin: isAdmin,
        kKeyMsgSeen: msgSeen,
        kKeyFromUid: fromUid,
        kKeyMessage: message,
        kKeyMsgType: msgType,
        kKeyMsgSeenTime: msgSeenTime,
        kKeyTimeStamp: FieldValue.serverTimestamp(),
      };
}
