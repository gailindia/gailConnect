// // Created By Amit Jangid on 27/12/21

// import 'dart:io';

// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:gail_connect/models/chat_notification.dart';
// import 'package:gail_connect/utils/utils.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:gail_connect/rest/gail_connect_services.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_room_controller.dart';

// class EmpGroupChatRoomController extends GetxController {
//   final String _tag = 'EmpGroupChatRoomController';

//   late String groupId;

//   bool isLoading = true, isImageUploading = false;

//   File? selectedImageFile;
//   EmpGroupInfo? empGroupInfo;

//   late List<ChatUser> chatUserList = [];
//   late List<ChatMessage> chatMessagesList = [], groupedChatMessagesList = [];

//   late Stream<QuerySnapshot> chatMessageStream;
//   late Stream<DocumentSnapshot> empGroupInfoStream;

//   final FirebaseFirestore _firestore = EmpChatController.to.firestore;
//   final FirebaseStorage _firebaseStorage = EmpChatController.to.firebaseStorage;

//   final ScrollController scrollController = ScrollController();
//   final TextEditingController messageController = TextEditingController();
//   final GailConnectServices _gailConnectServices = GailConnectServices.to;

//   @override
//   void onInit() {
//     super.onInit();

//     groupId = Get.arguments[kGroupId];
//     chatUserList = Get.arguments[kChatUsersList];

//     // calling get group info method
//     getGroupInfo();

//     // calling get group messages method
//     getGroupMessages();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kEmployeeGroupChatRoomScreen);
//   }

//   generateChatMessageList(final snapshot) {
//     groupedChatMessagesList = [];

//     chatMessagesList = chatMessagesList = snapshot.data!.docs
//         .map<ChatMessage>(
//             (_chatMsgDoc) => ChatMessage.fromGroupDoc(_chatMsgDoc))
//         .toList();

//     // calling group by method from collections package to group chat list by timestamp
//     final _groupByDate = groupBy(
//         chatMessagesList,
//         (ChatMessage _chatMessage) => convertTimeStampToDate(
//             _chatMessage.timestamp,
//             newDateFormat: 'yyyy-MM-dd'));

//     _groupByDate.forEach((_timestamp, _chatMessagesList) {
//       final ChatMessage chatMessage = ChatMessage(
//         fromUid: '',
//         isAdmin: true,
//         msgSeen: false,
//         message: _timestamp,
//         timestamp: Timestamp.now(),
//         msgType: MessageType.notify,
//         fromName: EmpChatController.to.currentUser!.lastMessageByName,
//       );

//       for (final ChatMessage _chatMessage in _chatMessagesList) {
//         groupedChatMessagesList.add(_chatMessage);
//       }

//       groupedChatMessagesList.add(chatMessage);
//     });
//   }

//   getGroupInfo() async {
//     isLoading = true;
//     update([kEmpGroupChatRoom]);

//     empGroupInfoStream =
//         _firestore.collection(kGroupsCollection).doc(groupId).snapshots();

//     isLoading = false;
//     update([kEmpGroupChatRoom]);
//   }

//   getGroupMessages() async {
//     chatMessageStream = _firestore
//         .collection(kGroupsCollection)
//         .doc(groupId)
//         .collection(kChatsCollection)
//         .orderBy(kKeyTimeStamp, descending: true)
//         .snapshots();
//   }

//   pickImage() async {
//     final XFile? _selectedImage = await ImagePicker()
//         .pickImage(imageQuality: 50, source: ImageSource.gallery);

//     if (_selectedImage != null) {
//       isImageUploading = true;
//       update([kEmpChatRoom]);

//       selectedImageFile = File(_selectedImage.path);

//       // calling upload image to firebase storage method
//       _uploadImageToFirebaseStorage();
//     }
//   }

//   _uploadImageToFirebaseStorage() async {
//     final String _fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final Reference _ref =
//         _firebaseStorage.ref().child(kKeyImages).child(_fileName);
//     final UploadTask _uploadTask = _ref.putFile(selectedImageFile!);

//     try {
//       final TaskSnapshot _taskSnapshot = await _uploadTask;
//       final String _imageUrl = await _taskSnapshot.ref.getDownloadURL();

//       // calling on message send method
//       _onMessageSend(message: _imageUrl, type: MessageType.image);

//       // calling send notification method
//       _sendNotification(isForImage: true, message: _imageUrl);
//     } on FirebaseException catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg: 'exception while uploading image to firebase storage',
//       );

//       isImageUploading = false;
//       update([kEmpChatRoom]);
//     }
//   }

//   _updateLastMessageForMembers(String message) async {
//     for (final ChatUser _chatUser in empGroupInfo!.groupMembersList) {
//       // here we will update last message for all the group members
//       await _firestore
//           .collection(kUsersCollection)
//           .doc(_chatUser.uid)
//           .collection(kChatListCollection)
//           .doc(groupId)
//           .update(
//         {
//           kKeyLastMessage: message,
//           kKeyLastMessageTime: FieldValue.serverTimestamp(),
//           kKeyLastMessageBy: EmpChatController.to.currentUser!.uid,
//           kKeyLastMessageByName: EmpChatController.to.currentUser!.name,
//         },
//       );
//     }
//   }

//   onTextMessageSend(String message) {
//     messageController.clear();

//     // calling on message send method
//     _onMessageSend(message: message, type: MessageType.text);

//     // calling send notification method
//     _sendNotification(message: message);
//   }

//   _onMessageSend({required String message, required int type}) async {

//     try {
//       if (message.trim().isNotEmpty) {
//         /*final DocumentReference _docRef = _firestore
//             .collection(kGroupsCollection)
//             .doc(groupId)
//             .collection(kChatsCollection)
//             .doc(DateTime.now().millisecondsSinceEpoch.toString());*/

//         final ChatMessage _chatMessage = ChatMessage(
//           msgType: type,
//           msgSeen: false,
//           message: message,
//           timestamp: Timestamp.now(),
//           fromUid: EmpChatController.to.currentUser!.uid,
//           fromName: EmpChatController.to.currentUser!.name,
//           isAdmin:
//               EmpChatController.to.currentUser!.uid == empGroupInfo!.createdBy,
//           // timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
//         );

//         scrollController.animateTo(0,
//             duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

//         // here we store message on firestore database for the group
//         // await _firestore.runTransaction((transaction) async => transaction.set(_docRef, _chatMessage.toGroupMap()));

//         await _firestore
//             .collection(kGroupsCollection)
//             .doc(groupId)
//             .collection(kChatsCollection)
//             .doc(DateTime.now().millisecondsSinceEpoch.toString())
//             .set(_chatMessage.toGroupMap());

//         // calling update last message for members method
//         await _updateLastMessageForMembers(message);
//       } else {

//       }
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg:
//             'exception while sending group message and storing to firebase firestore',
//       );
//       await _gailConnectServices.submitExceptionApi(
//         issue: e.toString(),
//         trace: s.toString(),
//         screen: "dispensary_add_call_controller",
//       );
//     }
//   }

//   _sendNotification({bool isForImage = false, required String message}) async {
//     try {
//       final List<String> _tokenIdList = [];
//       Map<String, dynamic> _notificationBody = {};

//       for (final ChatUser _chatUser in empGroupInfo!.groupMembersList) {
//         if (_chatUser.uid != EmpChatController.to.currentUser!.uid) {
//           _tokenIdList.add(_chatUser.notificationTokenId);
//         }
//       }

//       /*for (final ChatUser _chatUser in empGroupInfo!.groupMembersList) {
//         if (_chatUser.uid != EmpChatController.to.currentUser!.uid) {
//           final _userDoc = await EmpChatController.to.firestore.collection(kUsersCollection).doc(_chatUser.uid).get();
//           final ChatUser _chatUserFromUsersCollection = ChatUser.fromDoc(_userDoc);

//           _tokenIdList.add(_chatUserFromUsersCollection.notificationTokenId);
//         }
//       }*/

//       final ChatNotification _chatNotification = ChatNotification(
//         message: message,
//         chatRoomId: groupId,
//         tokenIdList: _tokenIdList,
//         groupName: empGroupInfo!.groupName,
//         imageUrl: isForImage ? message : null,
//         name: EmpChatController.to.currentUser!.name,
//       );

//       if (isForImage) {
//         _notificationBody = _chatNotification.toGroupImageMap();
//       } else {
//         _notificationBody = _chatNotification.toGroupMap();
//       }

//       // calling post notification with json method
//       ///TODO :: onesignal issue
//       // final _result =
//       //     await OneSignal.shared.postNotificationWithJson(_notificationBody);
//       // debugPrint('result of post notification with json is dfg: $_result');
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg:
//             'exception while sending notification using one signals post notification with json method',
//       );
//       await _gailConnectServices.submitExceptionApi(
//         issue: e.toString(),
//         trace: s.toString(),
//         screen: "dispensary_add_call_controller",
//       );
//     }
//   }

//   navigateToGroupInfoScreen() {
//     Get.toNamed(kEmpGroupChatInfoRoute, arguments: {
//       kGroupId: empGroupInfo!.groupId,
//       kChatUsersList: chatUserList
//     });
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     messageController.dispose();
//     super.dispose();
//   }
// }
