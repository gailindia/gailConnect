// // Created By Amit Jangid on 23/12/21

// import 'package:flutter/material.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:gail_connect/ui/widgets/logo_widget.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/emp_chat/chat_message_card.dart';
// import 'package:gail_connect/ui/widgets/custom_clipper/chat_bubble_shape.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_room_controller.dart';

// import '../../../styles/color_controller.dart';

// class EmpChatRoomScreen extends StatelessWidget {
//   const EmpChatRoomScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController= Get.put(ColorController());
//     return WillPopScope(
//       onWillPop: () {
//         // SharedPrefs.to.currentChatRoomId = '';
//         return Future.value(true);
//       },
//       child: GetBuilder<EmpChatRoomController>(
//         id: kEmpChatRoom,
//         init: EmpChatRoomController(),
//         builder: (_controller) {
//           return Scaffold(
//             appBar: CustomAppBar(
//                 title: '', titleWidget: _TitleWidget(controller: _controller)),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: _controller.chatMessageStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         // calling generate chat message list method
//                         _controller.generateChatMessageList(snapshot);

//                         return ListView.builder(
//                           reverse: true,
//                           cacheExtent: (Get.height * 2),
//                           controller: _controller.scrollController,
//                           padding: const EdgeInsets.symmetric(vertical: 6),
//                           itemCount: _controller.chatMessagesList.length,
//                           // itemCount: _controller.groupedChatMessagesList.length,
//                           itemBuilder: (context, _position) {
//                             final ChatMessage _chatMessage =
//                                 _controller.chatMessagesList[_position];
//                             // final ChatMessage _chatMessage = _controller.groupedChatMessagesList[_position];

//                             if (!_chatMessage.msgSeen &&
//                                 _chatMessage.fromUid !=
//                                     EmpChatController.to.currentUser!.uid) {
//                               // calling mark message seen for chat user method
//                               _controller.markMessageSeenForChatUser(
//                                 chatMessage: _chatMessage,
//                                 document: snapshot.data!.docs[_position],
//                               );
//                             }

//                             return ChatMessageCard(chatMessage: _chatMessage);
//                           },
//                         );
//                       }

//                       return const SizedBox.shrink();
//                     },
//                   ),
//                 ),
//                 verticalSpace6,
//                 if (_controller.isImageUploading) ...[
//                   SizedBox(
//                     height: Get.height * .4,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 6, right: 12),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           SizedBox(width: Get.width * .15),
//                           Flexible(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Flexible(
//                                   child: Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration:  BoxDecoration(
//                                       color: colorController.kPrimaryLightColor,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(12),
//                                         bottomLeft: Radius.circular(12),
//                                         bottomRight: Radius.circular(12),
//                                       ),
//                                     ),
//                                     child: const Center(
//                                       child: CircularProgressIndicator(
//                                           backgroundColor: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 CustomPaint(
//                                     painter:
//                                         ChatBubbleShape(colorController.kPrimaryLightColor)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   verticalSpace6,
//                 ],
//                 Visibility(
//                   visible: false,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         child: MaterialCard(
//                           borderRadius: 30,
//                           margin: const EdgeInsets.only(left: 6, bottom: 6),
//                           padding: const EdgeInsets.symmetric(horizontal: 3),
//                           child: TextFormField(
//                             minLines: 1,
//                             maxLines: 6,
//                             autocorrect: false,
//                             keyboardType: TextInputType.multiline,
//                             controller: _controller.messageController,
//                             textAlignVertical: TextAlignVertical.center,
//                             // textAlignVertical: TextAlignVertical.bottom,
//                             textCapitalization: TextCapitalization.sentences,
//                             decoration: InputDecoration(
//                               filled: true,
//                               hintText: kEnterMessage,
//                               fillColor: Colors.white,
//                               border: InputBorder.none,
//                               errorBorder: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               focusedBorder: InputBorder.none,
//                               contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 6),
//                               suffixIconConstraints:
//                                   const BoxConstraints(maxWidth: 36),
//                               prefixIconConstraints:
//                                   const BoxConstraints(maxWidth: 36),
//                               prefixIcon: IconButton(
//                                 onPressed: () {},
//                                 padding: const EdgeInsets.only(),
//                                 icon:  Icon(Fontisto.smiley,
//                                     size: 20, color: colorController.kPrimaryDarkColor),
//                               ),
//                               suffixIcon: IconButton(
//                                 padding: const EdgeInsets.only(),
//                                 // calling pick image method
//                                 onPressed: _controller.chooseFiles, //pickImage,
//                                 icon:  Icon(Icons.photo_library_outlined,
//                                     size: 20, color: colorController.kPrimaryDarkColor),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       horizontalSpace6,
//                       Visibility(
//                         visible: false,
//                         child: MaterialCard(
//                           borderRadius: 100,
//                           padding: const EdgeInsets.only(),
//                           margin: const EdgeInsets.only(right: 6, bottom: 6),
//                           child: Container(
//                             decoration:  BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: colorController.kPrimaryDarkColor),
//                             child: IconButton(
//                               padding: const EdgeInsets.only(),
//                               icon: const Icon(MaterialIcons.send,
//                                       color: Colors.white)
//                                   .marginOnly(left: 3),
//                               // calling on message send method
//                               onPressed: () => _controller.onTextMessageSend(
//                                   _controller.messageController.value.text),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _TitleWidget extends StatelessWidget {
//   final EmpChatRoomController controller;

//   const _TitleWidget({Key? key, required this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot>(
//       stream: controller.chatUserStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox.shrink();
//         }

//         final ChatUser _chatUser = ChatUser.fromDoc(snapshot.data);

//         return InkWell(
//           onTap: () =>
//               Get.toNamed(kEmployeeInfoRoute, arguments: controller.chatUser),
//           child: Row(
//             children: [
//               const LogoWidget(height: 36),
//               horizontalSpace6,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(_chatUser.name,
//                         maxLines: 1,
//                         style: textStyle16Bold.copyWith(color: Colors.white)),
//                     verticalSpace3,
//                     Text(
//                       _chatUser.status.toLowerCase(),
//                       maxLines: 1,
//                       style: textStyle13Normal.copyWith(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
