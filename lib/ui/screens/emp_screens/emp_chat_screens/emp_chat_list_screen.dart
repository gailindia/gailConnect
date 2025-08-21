// // Created By Amit Jangid on 23/12/21

// import 'package:flutter/material.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/loading_widget.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/emp_chat/chat_msg_time_widget.dart';
// import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_list_controller.dart';

// import '../../../styles/color_controller.dart';

// class EmpChatListScreen extends StatelessWidget {
//   const EmpChatListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController= Get.put(ColorController());

//     return GetBuilder<EmpChatListController>(
//       id: kEmpChat,
//       init: EmpChatListController(),
//       builder: (_controller) {
//         return Scaffold(
//           appBar:  CustomAppBar(title: kEmpChat),
//           // floatingActionButton: FloatingActionButton(
//           //   backgroundColor: colorController.kPrimaryDarkColor,
//           //   child: const Icon(Entypo.message, size: 30),
//           //   onPressed: () => Get.toNamed(kSelectEmpRoute, arguments: _controller.chatUserList),
//           // ),

//           floatingActionButton: Visibility(
//             child: FloatingActionButton(
//               backgroundColor: colorController.kPrimaryDarkColor,
//               child: const Icon(Entypo.message, size: 30),
//               onPressed: () => Get.toNamed(kSelectEmpRoute,
//                   arguments: _controller.chatUserList),
//             ),
//             // visible: SharedPrefs.to.isGroupAdmin,
//           ),

//           body: _controller.isLoading
//               ? const LoadingWidget()
//               : StreamBuilder<QuerySnapshot>(
//                   stream: _controller.chatUserStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       _controller.conversationChatList = snapshot.data!.docs
//                           .map<ChatUser>((_userDocument) =>
//                               ChatUser.fromDoc(_userDocument))
//                           .toList();

//                       if (_controller.conversationChatList.isNotEmpty) {
//                         return ListView.builder(
//                           itemCount: _controller.conversationChatList.length,
//                           padding: const EdgeInsets.only(
//                               left: 12, right: 12, bottom: 84),
//                           itemBuilder: (context, _position) {
//                             final ChatUser _chatUser =
//                                 _controller.conversationChatList[_position];

//                             return MaterialCard(
//                               borderRadius: 12,
//                               padding: const EdgeInsets.all(6),
//                               // calling navigate to chat room
//                               onTap: () => _controller.navigateToChatRoom(
//                                   chatUser: _chatUser),
//                               child: Row(
//                                 children: [
//                                   CircularNetworkImageWidget(
//                                       imageUrl: _chatUser.profileUrl),
//                                   horizontalSpace12,
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(_chatUser.name,
//                                             style: textStyle16Bold),
//                                         verticalSpace6,
//                                         _chatUser.isGroupChat
//                                             // calling show message by name for group method
//                                             ? _showMessageByNameForGroup(
//                                                 chatUser: _chatUser,
//                                                 controller: _controller)
//                                             // calling show last message method
//                                             : _showLastMessage(
//                                                 _chatUser.lastMessage),
//                                         verticalSpace6,
//                                         Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: ChatMsgTimeWidget(
//                                             textColor: colorController.kBlackColor,
//                                             timeStamp:
//                                                 _chatUser.lastMessageTime,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     }

//                     return const SizedBox.shrink();
//                   },
//                 ),
//         );
//       },
//     );
//   }

//   Widget _showMessageByNameForGroup(
//       {required ChatUser chatUser, required EmpChatListController controller}) {
//     String _lastMessage = chatUser.lastMessage;
//     final String _currentUsersName = EmpChatController.to.currentUser!.name;

//     if (chatUser.lastMessageBy == EmpChatController.to.currentUser!.uid) {
//       if (_lastMessage
//           .toLowerCase()
//           .contains('https://firebasestorage.googleapis.com'.toLowerCase())) {
//         _lastMessage = '$kYou: $kImage';

//         return _ImageMessage(message: _lastMessage);
//       } else {
//         return _TextMessage(message: '$kYou: $_lastMessage');
//       }
//     } else {
//       if (_lastMessage
//           .toLowerCase()
//           .contains('https://firebasestorage.googleapis.com'.toLowerCase())) {
//         final String _name =
//             chatUser.lastMessageByName.replaceAll(' ', ' ').split(' ')[0];
//         _lastMessage = '$_name: $kImage';

//         return _ImageMessage(message: _lastMessage);
//       } else {
//         final String _name =
//             chatUser.lastMessageByName.replaceAll(' ', ' ').split(' ')[0];
//         _lastMessage = _lastMessage
//             .replaceAll('  ', ' ')
//             .replaceAll(_currentUsersName, kYou);
//         _lastMessage = '$_name: $_lastMessage';

//         return _TextMessage(message: _lastMessage);
//       }
//     }
//   }

//   Widget _showLastMessage(String message) {
//     if (message
//         .toLowerCase()
//         .contains('https://firebasestorage.googleapis.com'.toLowerCase())) {
//       return const _ImageMessage(message: kImage);
//     } else {
//       return _TextMessage(message: message);
//     }
//   }
// }

// class _ImageMessage extends StatelessWidget {
//   final String message;

//   const _ImageMessage({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Icon(Icons.photo_library_outlined, size: 20, color: Colors.black),
//         horizontalSpace3,
//         Text(message,
//             style: textStyle12Normal,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis),
//       ],
//     );
//   }
// }

// class _TextMessage extends StatelessWidget {
//   final String message;

//   const _TextMessage({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(message,
//         maxLines: 1, style: textStyle12Normal, overflow: TextOverflow.ellipsis);
//   }
// }
