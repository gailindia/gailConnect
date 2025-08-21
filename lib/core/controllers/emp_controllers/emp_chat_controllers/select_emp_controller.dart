// // Created By Amit Jangid on 23/12/21

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';

// class SelectEmpController extends GetxController {
//   bool isLoading = false;
//   List<ChatUser> chatUserList = [], filteredChatUserList = [];

//   final TextEditingController searchEmployeeController =
//       TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();

//     chatUserList = Get.arguments;
//     filteredChatUserList = chatUserList;
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kSelectContactScreen);
//   }

//   searchEmployee(String _query) {
//     if (_query.trim().isNotEmpty) {
//       final List<ChatUser> _tempChatUserList = [];

//       for (final ChatUser _chatUser in chatUserList) {
//         if (_chatUser.cpf.contains(_query.trim()) ||
//             _chatUser.name.toLowerCase().contains(_query.toLowerCase()) ||
//             _chatUser.email.toLowerCase().contains(_query.toLowerCase())) {
//           _tempChatUserList.add(_chatUser);
//         }
//       }

//       filteredChatUserList = _tempChatUserList;
//       update([kSelectContact]);
//     } else {
//       filteredChatUserList = chatUserList;
//       update([kSelectContact]);
//     }
//   }

//   clearEmployeeSearch() {
//     searchEmployeeController.clear();

//     // calling search employee method
//     searchEmployee('');
//   }

//   String generateChatRoomId(ChatUser chatUser) {
//     String _chatRoomId = '';
//     final String _currentUsersUid = EmpChatController.to.currentUser!.uid;

//     if (_currentUsersUid.hashCode <= chatUser.uid.hashCode) {
//       _chatRoomId = '$_currentUsersUid-${chatUser.uid}';
//     } else {
//       _chatRoomId = '${chatUser.uid}-$_currentUsersUid';
//     }

//     return _chatRoomId;
//   }

//   navigateToChatRoom({required ChatUser chatUser}) {
//     Get.offNamed(
//       kEmpChatRoomRoute,
//       // calling generate chat room id method
//       arguments: {
//         kChatRoomId: generateChatRoomId(chatUser),
//         kChatUser: chatUser,
//         kChatUsersList: chatUserList
//       },
//     );
//   }

//   @override
//   void dispose() {
//     searchEmployeeController.dispose();

//     super.dispose();
//   }
// }
