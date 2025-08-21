// // Created By Amit Jangid on 23/12/21

// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:gail_connect/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gail_connect/models/chat_notification.dart';
// import 'package:gail_connect/rest/gail_connect_services.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:secure_shared_preferences/secure_shared_pref.dart';

// class EmpChatRoomController extends GetxController with WidgetsBindingObserver {
//   final String _tag = 'EmpChatRoomController';

//   final ScrollController scrollController = ScrollController();
//   final TextEditingController messageController = TextEditingController();

//   static EmpChatRoomController get to => Get.find<EmpChatRoomController>();
//   final GailConnectServices _gailConnectServices = GailConnectServices.to;

//   String? chatRoomId;
//   ChatUser? chatUser;
//   File? selectedImageFile;
//   List<File> docs = [];
//   bool isPDF = false;

//   // List<PlatformFile> selectedFilesList = [];
//   // PlatformFile? selectedFile;
//   XFile? capturedImage;

//   bool isImageUploading = false;

//   late Stream<QuerySnapshot> chatMessageStream;
//   late Stream<DocumentSnapshot> chatUserStream;

//   late List<ChatUser> chatUsersList = [];
//   late List<ChatMessage> chatMessagesList = [], groupedChatMessagesList = [];

//   @override
//   void onInit() async{
//     super.onInit();

//     WidgetsBinding.instance.addObserver(this);
//     try {
//       chatUser = Get.arguments[kChatUser];
//       chatRoomId = Get.arguments[kChatRoomId];
//       chatUsersList = Get.arguments[kChatUsersList];
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: 'main',
//         exceptionMsg: 'exception while initializing one signal sdk',
//       );
//     }

//     SecureSharedPref pref = await SecureSharedPref.getInstance();
//     await pref.putString("currentChatRoomId", chatRoomId??"");
//     // SharedPrefs.to.currentChatRoomId = chatRoomId ?? '';

//     // calling get chat data method
//     _getChatData();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kEmployeeChatRoomScreen);

//     // GailConnectServices.to.hitCountApi(activity: kEmployeesScreen);
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async{
//     SecureSharedPref pref = await SecureSharedPref.getInstance();

//     if (state == AppLifecycleState.resumed) {
//       await pref.putString("currentChatRoomId", chatRoomId??"");
//     } else {
//       await pref.putString("currentChatRoomId", "");
//     }
//   }

//   _getChatData() async {
//     chatUserStream = EmpChatController.to.firestore
//         .collection(kUsersCollection)
//         .doc(chatUser!.uid)
//         .snapshots();

//     chatMessageStream = EmpChatController.to.firestore
//         .collection(kChatRoomsCollection)
//         .doc(chatRoomId!)
//         .collection(chatRoomId!)
//         .orderBy(kKeyTimeStamp, descending: true)
//         .snapshots();
//   }

//   markMessageSeenForChatUser(
//       {required ChatMessage chatMessage,
//       required DocumentSnapshot? document}) async {
//     if (document != null) {
//       final ChatMessage _chatMessage = ChatMessage.fromDoc(document);

//       await EmpChatController.to.firestore
//           .collection(kChatRoomsCollection)
//           .doc(chatRoomId!)
//           .collection(chatRoomId!)
//           .doc(document.id)
//           .update(_chatMessage.toMsgSeenMap());
//     }
//   }

//   generateChatMessageList(final snapshot) {
//     // groupedChatMessagesList = [];
//     chatMessagesList = snapshot.data!.docs
//         .map<ChatMessage>((_chatMsgDoc) => ChatMessage.fromDoc(_chatMsgDoc))
//         .toList();

//     /*// calling group by method from collections package to group chat list by timestamp
//     final _groupByDate = groupBy(chatMessagesList,
//         (ChatMessage _chatMessage) => convertTimeStampToDate(_chatMessage.timestamp, newDateFormat: 'yyyy-MM-dd'));

//     _groupByDate.forEach((_timestamp, _chatMessagesList) {
//       final ChatMessage chatMessage = ChatMessage(
//         fromUid: '',
//         msgSeen: false,
//         message: _timestamp,
//         timestamp: Timestamp.now(),
//         msgType: MessageType.notify,
//       );

//       for (final ChatMessage _chatMessage in _chatMessagesList) {
//         groupedChatMessagesList.add(_chatMessage);
//       }

//       groupedChatMessagesList.add(chatMessage);
//     });*/
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

//   chooseFiles() async {
//     try {
//       final FilePickerResult? _result = await FilePicker.platform.pickFiles();

//       if (_result != null) {
//         // capturedImage = null;
//         // selectedFilesList = _result.files;

//         update([kEmpChatRoom]);
//         // selectedImageFile = _result.files.single.path;
//         // file = _result.files.single.path!;
//         final PlatformFile fileo = _result.files.first;
//         selectedImageFile = File(fileo.path!);
//         if (fileo.path!.contains(".pdf")) {
//           isPDF = true;
//         }
//         _uploadImageToFirebaseStorage();
//         // final File fileForFirebase = File(fileo.path!);
//       }
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg: 'exception while choosing files',
//       );
//     }
//   }

//   _uploadImageToFirebaseStorage() async {
//     // final String _fileExtension = extension(selectedImageFile!.path);
//     final String _fileName;
//     if (isPDF) {
//       _fileName =
//           ("-isPDF-") + DateTime.now().millisecondsSinceEpoch.toString();
//     } else {
//       _fileName =
//           ("-isIMAGE-") + DateTime.now().millisecondsSinceEpoch.toString();
//     }
//     final Reference _ref = EmpChatController.to.firebaseStorage
//         .ref()
//         .child(kKeyImages)
//         .child(_fileName);
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

//   onTextMessageSend(String message) {
//     messageController.clear();

//     // calling on message send method
//     _onMessageSend(message: message, type: MessageType.text);

//     // calling send notification method
//     _sendNotification(message: message);
//   }

//   _checkAndAddUserToChatList() async {
//     // calling _check if user exists in chat list method
//     final bool _isChatUserExistsInChatList = await _checkIfUserExistsInChatList(
//       user2Uid: chatUser!.uid,
//       user1Uid: EmpChatController.to.currentUser!.uid,
//     );

//     if (!_isChatUserExistsInChatList) {
//       // calling add user to chat list method
//       _addUserToChatList(
//           userUid: EmpChatController.to.currentUser!.uid, chatUser: chatUser!);
//     }

//     // calling _check if user exists in chat list method
//     final bool _isCurrentUserExistsInChatList =
//         await _checkIfUserExistsInChatList(
//       user1Uid: chatUser!.uid,
//       user2Uid: EmpChatController.to.currentUser!.uid,
//     );

//     if (!_isCurrentUserExistsInChatList) {
//       final ChatUser? _currentChatUser = (await EmpChatController.to.firestore
//               .collection(kUsersCollection)
//               .where(kKeyUid, isEqualTo: EmpChatController.to.currentUser!.uid)
//               .get())
//           .docs
//           .map<ChatUser>((e) => ChatUser.fromDoc(e))
//           .toList()
//           .single;

//       if (_currentChatUser != null) {
//         // calling add user to chat list method
//         _addUserToChatList(userUid: chatUser!.uid, chatUser: _currentChatUser);
//       }
//     }
//   }

//   _checkIfUserExistsInChatList(
//       {required String user1Uid, required String user2Uid}) async {
//     final _chatList = (await EmpChatController.to.firestore
//             .collection(kUsersCollection)
//             .doc(user1Uid)
//             .collection(kChatListCollection)
//             .where(kKeyUid, isEqualTo: user2Uid)
//             .get())
//         .docs
//         .map((e) => ChatUser.fromDoc(e));

//     if (_chatList.isNotEmpty) {
//     } else {
//     }

//     return _chatList.isNotEmpty;
//   }

//   _addUserToChatList(
//       {required String userUid, required ChatUser chatUser}) async {
//     chatUser.isGroupChat = false;
//     chatUser.chatRoomOrGroupId = chatRoomId!;

//     await EmpChatController.to.firestore
//         .collection(kUsersCollection)
//         .doc(userUid)
//         .collection(kChatListCollection)
//         .doc(chatUser.uid)
//         .set(chatUser.toMap());
//   }

//   _updateLastMessageForCurrentUser({required String message}) async {
//     await EmpChatController.to.firestore
//         .collection(kUsersCollection)
//         .doc(EmpChatController.to.currentUser!.uid)
//         .collection(kChatListCollection)
//         .doc(chatUser!.uid)
//         .update(chatUser!.toChatListMap(message));
//   }

//   _updateLastMessageForUser({required String message}) async {
//     await EmpChatController.to.firestore
//         .collection(kUsersCollection)
//         .doc(chatUser!.uid)
//         .collection(kChatListCollection)
//         .doc(EmpChatController.to.currentUser!.uid)
//         .update(chatUser!.toChatListMap(message));
//   }

//   _onMessageSend({required String message, required int type}) async {
//     try {
//       if (message.trim().isNotEmpty) {
//         final ChatMessage _chatMessage = ChatMessage(
//           msgType: type,
//           msgSeen: false,
//           message: message,
//           timestamp: Timestamp.now(),
//           fromUid: EmpChatController.to.currentUser!.uid,
//         );

//         scrollController.animateTo(0,
//             duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

//         await EmpChatController.to.firestore
//             .collection(kChatRoomsCollection)
//             .doc(chatRoomId!)
//             .collection(chatRoomId!)
//             .doc(DateTime.now().millisecondsSinceEpoch.toString())
//             .set(_chatMessage.toMap());

//         // calling check and add user to chat list method
//         await _checkAndAddUserToChatList();

//         // calling update last message for current user method
//         await _updateLastMessageForCurrentUser(message: message);

//         // calling update last message for user method
//         await _updateLastMessageForUser(message: message);

//         isImageUploading = false;
//         selectedImageFile = null;

//         update([kEmpChatRoom]);
//       }
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg:
//             'exception while sending message and storing to firebase firestore',
//       );
//       await _gailConnectServices.submitExceptionApi(
//         issue: e.toString(),
//         trace: s.toString(),
//         screen: "dispensary_add_call_controller",
//       );
//     }
//   }

//   _sendNotification({bool isForImage = false, required String message}) async {
//     Map<String, dynamic> _notificationBody = {};

//     if (message
//         .toLowerCase()
//         .contains('https://firebasestorage.googleapis.com'.toLowerCase())) {
//       isForImage = true;
//     }

//     /*final _userDocument = await EmpChatController.to.firestore.collection(kUsersCollection).doc(chatUser!.uid).get();
//     final ChatUser _chatUser = ChatUser.fromDoc(_userDocument);*/
//     final ChatNotification _chatNotification = ChatNotification(
//       chatRoomId: chatRoomId!,
//       imageUrl: isForImage ? message : null,
//       message: isForImage ? kImage : message,
//       tokenIdList: [chatUser!.notificationTokenId],
//       name: EmpChatController.to.currentUser!.name,
//     );

//     if (isForImage) {
//       _notificationBody = _chatNotification.toImageMap();
//     } else {
//       _notificationBody = _chatNotification.toMap();
//     }

//     // calling post notification with json method
//     ///TODO :: onesignal issue
//     // final _result =
//     //     await OneSignal.shared.postNotificationWithJson(_notificationBody);
//     // debugPrint('result of post notification with json is: $_result');
//     // _result.cast<String, dynamic>();
//   }

//   @override
//   void dispose() async{
//     scrollController.dispose();
//     messageController.dispose();
//     SecureSharedPref pref = await SecureSharedPref.getInstance();

//     await pref.putString("currentChatRoomId", "");

//     WidgetsBinding.instance.removeObserver(this);

//     super.dispose();
//   }
// }

// abstract class MessageType {
//   static const text = 0;
//   static const image = 1;
//   static const notify = 2;
//   static const doc = 3;
// }
