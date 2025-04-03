// // Created By Amit Jangid on 27/12/21

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/loading_widget.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/emp_chat/chat_message_card.dart';
// import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_group_chat_controllers/emp_group_chat_room_controller.dart';

// import '../../../../styles/color_controller.dart';

// class EmpGroupChatRoomScreen extends StatelessWidget {
//   const EmpGroupChatRoomScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController= Get.put(ColorController());
//     return GetBuilder<EmpGroupChatRoomController>(
//       id: kEmpGroupChatRoom,
//       init: EmpGroupChatRoomController(),
//       builder: (_controller) {
//         return Scaffold(
//           appBar: CustomAppBar(
//               title: '', titleWidget: _TitleWidget(controller: _controller)),
//           body: _controller.isLoading
//               ? const LoadingWidget()
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: _controller.chatMessageStream,
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             // calling generate chat message list method
//                             _controller.generateChatMessageList(snapshot);

//                             return ListView.builder(
//                               reverse: true,
//                               controller: _controller.scrollController,
//                               padding: const EdgeInsets.symmetric(vertical: 6),
//                               itemCount: _controller.chatMessagesList.length,
//                               // itemCount: _controller.groupedChatMessagesList.length,
//                               itemBuilder: (context, _position) {
//                                 final ChatMessage _chatMessage =
//                                     _controller.chatMessagesList[_position];
//                                 // final ChatMessage _chatMessage = _controller.groupedChatMessagesList[_position];

//                                 return ChatMessageCard(
//                                     chatMessage: _chatMessage);
//                               },
//                             );
//                           }
//                           return const SizedBox.shrink();
//                         },
//                       ),
//                     ),
//                     Visibility(
//                       visible: false,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: MaterialCard(
//                               borderRadius: 30,
//                               margin: const EdgeInsets.only(left: 6, bottom: 6),
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 3),
//                               child: TextFormField(
//                                 minLines: 1,
//                                 maxLines: 6,
//                                 autocorrect: false,
//                                 keyboardType: TextInputType.multiline,
//                                 controller: _controller.messageController,
//                                 textAlignVertical: TextAlignVertical.center,
//                                 // textAlignVertical: TextAlignVertical.bottom,
//                                 textCapitalization:
//                                     TextCapitalization.sentences,
//                                 decoration: InputDecoration(
//                                   filled: true,
//                                   hintText: kEnterMessage,
//                                   fillColor: Colors.white,
//                                   border: InputBorder.none,
//                                   errorBorder: InputBorder.none,
//                                   enabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   contentPadding:
//                                       const EdgeInsets.symmetric(vertical: 6),
//                                   suffixIconConstraints:
//                                       const BoxConstraints(maxWidth: 36),
//                                   prefixIconConstraints:
//                                       const BoxConstraints(maxWidth: 36),
//                                   prefixIcon: IconButton(
//                                     onPressed: () {},
//                                     padding:  EdgeInsets.only(),
//                                     icon:  Icon(Fontisto.smiley,
//                                         size: 20, color: colorController.kPrimaryDarkColor),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     padding: const EdgeInsets.only(),
//                                     // calling pick image method
//                                     onPressed: _controller.pickImage,
//                                     icon:  Icon(
//                                         Icons.photo_library_outlined,
//                                         size: 20,
//                                         color: colorController.kPrimaryDarkColor),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           horizontalSpace6,
//                           Visibility(
//                             visible: false,
//                             child: MaterialCard(
//                               borderRadius: 100,
//                               padding: const EdgeInsets.only(),
//                               margin:
//                                   const EdgeInsets.only(right: 6, bottom: 6),
//                               child: Container(
//                                 decoration:  BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: colorController.kPrimaryDarkColor),
//                                 child: IconButton(
//                                   padding: const EdgeInsets.only(),
//                                   icon: const Icon(MaterialIcons.send,
//                                           color: Colors.white)
//                                       .marginOnly(left: 3),
//                                   // calling on message send method
//                                   onPressed: () =>
//                                       _controller.onTextMessageSend(_controller
//                                           .messageController.value.text),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }

// class _TitleWidget extends StatelessWidget {
//   final EmpGroupChatRoomController controller;

//   const _TitleWidget({Key? key, required this.controller}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot>(
//       stream: controller.empGroupInfoStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox.shrink();
//         }

//         controller.empGroupInfo = EmpGroupInfo.fromDoc(snapshot.data);

//         return InkWell(
//           onTap: controller.navigateToGroupInfoScreen,
//           child: Row(
//             children: [
//               CircularNetworkImageWidget(
//                   imageWidth: 40,
//                   imageHeight: 40,
//                   imageUrl: controller.empGroupInfo!.groupIcon),
//               horizontalSpace6,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.empGroupInfo!.groupName,
//                       maxLines: 1,
//                       style: textStyle16Bold.copyWith(color: Colors.white),
//                     ),
//                     verticalSpace3,
//                     Text(
//                       "${controller.empGroupInfo!.groupMembersList.length} $kMembers",
//                       maxLines: 1,
//                       style: textStyle12Normal.copyWith(color: Colors.white),
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
