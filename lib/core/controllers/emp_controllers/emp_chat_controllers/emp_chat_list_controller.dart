// // Created By Amit Jangid on 23/12/21

// import 'package:get/get.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';

// class EmpChatListController extends GetxController {
//   late Stream<QuerySnapshot> chatUserStream;

//   bool isLoading = true;

//   List<ChatUser> chatUserList = [];
//   List<ChatUser> conversationChatList = [];

//   @override
//   void onInit() {
//     super.onInit();
//     // calling get all chat users method
//     getAllChatUsers();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kEmployeeChatListScreen);
//   }

//   getAllChatUsers() async {
//     if (EmpChatController.to.currentUser != null) {
//       isLoading = true;
//       update([kEmpChat]);
//       final _document = await EmpChatController.to.firestore
//           .collection(kUsersCollection)
//           .where(kKeyUid, isNotEqualTo: EmpChatController.to.currentUser!.uid)
//           .get();
//       final _userMapList = _document.docs.map((e) => e.data()).toList();
//       chatUserList = _userMapList
//           .map<ChatUser>((_userMap) => ChatUser.fromMap(_userMap))
//           .toList();

//       // calling get all conversations method
//       await getAllConversations();

//       isLoading = false;
//       update([kEmpChat]);
//     } else {
//       // calling get current chat user method
//       await EmpChatController.to.getCurrentChatUser();
//       // calling get all chat users method
//       await getAllChatUsers();
//     }
//   }

//   getAllConversations() async {
//     isLoading = true;
//     update([kEmpChat]);

//     chatUserStream = EmpChatController.to.firestore
//         .collection(kUsersCollection)
//         .doc(EmpChatController.to.currentUser!.uid)
//         .collection(kChatListCollection)
//         .orderBy(kKeyLastMessageTime, descending: true)
//         .snapshots();

//     isLoading = false;
//     update([kEmpChat]);
//   }

//   navigateToChatRoom({required ChatUser chatUser}) {
//     if (chatUser.isGroupChat) {
//       Get.toNamed(
//         kEmpGroupChatRoomRoute,
//         arguments: {
//           kGroupId: chatUser.chatRoomOrGroupId,
//           kChatUsersList: chatUserList
//         },
//       );
//     } else {
//       Get.toNamed(
//         kEmpChatRoomRoute,
//         arguments: {
//           kChatUser: chatUser,
//           kChatUsersList: chatUserList,
//           kChatRoomId: chatUser.chatRoomOrGroupId
//         },
//       );
//     }
//   }
// }
