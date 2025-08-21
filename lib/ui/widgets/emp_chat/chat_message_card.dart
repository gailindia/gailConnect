// // Created By Amit Jangid on 28/12/21

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:gail_connect/utils/open_pdf.dart';
// import 'package:get/get.dart';
// import 'package:multiutillib/utils/constants.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/utils/date_time_extension.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/ui/screens/full_image_screen.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/network_image_widget.dart';
// import 'package:gail_connect/ui/widgets/open_container_transition.dart';
// import 'package:gail_connect/ui/widgets/emp_chat/chat_msg_time_widget.dart';
// import 'package:gail_connect/ui/widgets/custom_clipper/chat_bubble_shape.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_room_controller.dart';
// import 'package:validators/validators.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../styles/color_controller.dart';

// class ChatMessageCard extends StatelessWidget {
//   final ChatMessage chatMessage;

//   const ChatMessageCard({Key? key, required this.chatMessage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return chatMessage.msgType == MessageType.text
//         ? _TextMessageCard(chatMessage: chatMessage)
//         : chatMessage.msgType == MessageType.image
//             ? _ImageMessageCard(chatMessage: chatMessage)
//             : (chatMessage.msgType == MessageType.notify)
//                 ? _NotifyMessageCard(chatMessage: chatMessage)
//                 : const SizedBox.shrink();
//   }
// }

// class _TextMessageCard extends StatelessWidget {
//   final ChatMessage chatMessage;

//   const _TextMessageCard({Key? key, required this.chatMessage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController = Get.put(ColorController());//colorController.
//      Color _bubbleColor = colorController.kPrimaryLightColor;
//     final bool _isCurrentUser =
//         (chatMessage.fromUid == EmpChatController.to.currentUser!.uid);

//     // final Color _bubbleColor = _isCurrentUser ? colorController.kPrimaryLightColor : Colors.grey[600]!;

//     return Padding(
//       padding: EdgeInsets.only(
//           top: 6,
//           left: !_isCurrentUser ? 12 : 0,
//           right: _isCurrentUser ? 12 : 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           if (_isCurrentUser) ...[SizedBox(width: Get.width * .15)],
//           Flexible(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: _isCurrentUser
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: [
//                 if (!_isCurrentUser) ...[
//                   Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.rotationY(pi),
//                     child: CustomPaint(painter: ChatBubbleShape(_bubbleColor)),
//                   ),
//                 ],
//                 Flexible(
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: _bubbleColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: const Radius.circular(12),
//                         bottomRight: const Radius.circular(12),
//                         topLeft: _isCurrentUser
//                             ? const Radius.circular(12)
//                             : const Radius.circular(0),
//                         topRight: !_isCurrentUser
//                             ? const Radius.circular(12)
//                             : const Radius.circular(0),
//                       ),
//                     ),
//                     child: Stack(
//                       children: [
//                         Column(
//                           crossAxisAlignment: _isCurrentUser
//                               ? CrossAxisAlignment.end
//                               : CrossAxisAlignment.start,
//                           children: [
//                             if (chatMessage.fromName.isNotEmpty) ...[
//                               // Text(
//                               //   _isCurrentUser ? kYou : chatMessage.fromName,
//                               //   style: textStyle12Normal.copyWith(
//                               //       fontSize: 10, color: Colors.white),
//                               // ),
//                               verticalSpace6,
//                             ],
//                             isURL(chatMessage.message, requireTld: false)
//                                 ? Linkify(
//                                     onOpen: (link) async {
//                                       if (await canLaunch(link.url)) {
//                                         await launch(link.url);
//                                       } else {
//                                         throw 'Could not launch $link';
//                                       }
//                                     },
//                                     text: chatMessage.message,
//                                     style: TextStyle(color: Colors.white),
//                                     linkStyle: TextStyle(color: Colors.yellow),
//                                   )
//                                 : Text(chatMessage.message,
//                                     style: textStyle14Normal.copyWith(
//                                         color: Colors.white)),
//                             verticalSpace6,
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 ChatMsgTimeWidget(
//                                     timeStamp: chatMessage.timestamp),
//                                 horizontalSpace6,
//                                 _isCurrentUser
//                                     ? chatMessage.msgSeen
//                                         ? const Icon(Ionicons.checkmark_done,
//                                             size: 14)
//                                         : const Icon(Ionicons.checkmark,
//                                             size: 14)
//                                     : const SizedBox.shrink(),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (_isCurrentUser) ...[
//                   CustomPaint(painter: ChatBubbleShape(_bubbleColor))
//                 ],
//               ],
//             ),
//           ),
//           if (!_isCurrentUser) ...[SizedBox(width: Get.width * .15)],
//         ],
//       ),
//     );
//   }
// }

// class _ImageMessageCard extends StatelessWidget {
//   final ChatMessage chatMessage;

//   const _ImageMessageCard({Key? key, required this.chatMessage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//      Color _bubbleColor = colorController.kPrimaryLightColor;
//     final bool _isCurrentUser =
//         (chatMessage.fromUid == EmpChatController.to.currentUser!.uid);
//     // final Color _bubbleColor = _isCurrentUser ? colorController.kPrimaryLightColor : Colors.grey[600]!;

//     // return SizedBox(
//     // height: Get.height * .3,
//     return Padding(
//       padding: EdgeInsets.only(
//           top: 10,
//           left: !_isCurrentUser ? 12 : 0,
//           right: _isCurrentUser ? 12 : 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           // if (_isCurrentUser) ...[SizedBox(width: Get.width * .15)],
//           Flexible(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: _isCurrentUser
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: [
//                 if (!_isCurrentUser) ...[
//                   Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.rotationY(pi),
//                     child: CustomPaint(painter: ChatBubbleShape(_bubbleColor)),
//                   ),
//                 ],
//                 Flexible(
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: _bubbleColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: const Radius.circular(12),
//                         bottomRight: const Radius.circular(12),
//                         topLeft: _isCurrentUser
//                             ? const Radius.circular(12)
//                             : const Radius.circular(0),
//                         topRight: !_isCurrentUser
//                             ? const Radius.circular(12)
//                             : const Radius.circular(0),
//                       ),
//                     ),
//                     child: OpenContainerTransition(
//                       openBuilder: (context, action) =>
//                           chatMessage.message.contains("isPDF")
//                               ? OpenPDF(chatMessage.message)
//                               // ? const PDF().fromUrl(
//                               //     chatMessage.message,
//                               //     placeholder: (double progress) =>
//                               //         Center(child: Text('$progress %')),
//                               //     errorWidget: (dynamic error) =>
//                               //         Center(child: Text(error.toString())),
//                               //   )
//                               : FullImageScreen(
//                                   title: '', imageUrl: chatMessage.message),
//                       // }
//                       // },
//                       closedShape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(6))),
//                       closedBuilder: (context, action) {
//                         return Stack(
//                           children: [
//                             chatMessage.message.contains('isPDF')
//                                 ? SizedBox(
//                                     height: 200,
//                                     child: NetworkImageWidget(
//                                       borderRadius: 6,
//                                       imageUrl: chatMessage.message,
//                                       margin: const EdgeInsets.only(),
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     height: 200,
//                                     child: NetworkImageWidget(
//                                       borderRadius: 6,
//                                       imageUrl: chatMessage.message,
//                                       margin: const EdgeInsets.only(),
//                                     ),
//                                   ),
//                             if (chatMessage.fromName.isNotEmpty) ...[
//                               Positioned(
//                                 top: 0,
//                                 right: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 6, horizontal: 12),
//                                   decoration:  BoxDecoration(
//                                     color: colorController.kPrimaryLightColor,
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(6)),
//                                   ),
//                                   child: Text(
//                                     _isCurrentUser
//                                         ? kYou
//                                         : chatMessage.fromName,
//                                     textAlign: TextAlign.end,
//                                     style: textStyle12Normal.copyWith(
//                                         fontSize: 10, color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               verticalSpace6,
//                             ],
//                             verticalSpace6,
//                             Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 6, horizontal: 12),
//                                   decoration:  BoxDecoration(
//                                     color: colorController.kPrimaryLightColor,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(6)),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       ChatMsgTimeWidget(
//                                           timeStamp: chatMessage.timestamp),
//                                       horizontalSpace6,
//                                       _isCurrentUser
//                                           ? chatMessage.msgSeen
//                                               ? const Icon(
//                                                   Ionicons.checkmark_done,
//                                                   size: 14)
//                                               : const Icon(Ionicons.checkmark,
//                                                   size: 14)
//                                           : const SizedBox.shrink(),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 if (_isCurrentUser) ...[
//                   CustomPaint(painter: ChatBubbleShape(_bubbleColor))
//                 ],
//               ],
//             ),
//           ),
//           if (!_isCurrentUser) ...[SizedBox(width: Get.width * .15)],
//         ],
//       ),
//     );
//     // );
//   }
// }

// class _NotifyMessageCard extends StatelessWidget {
//   final ChatMessage chatMessage;

//   const _NotifyMessageCard({Key? key, required this.chatMessage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final double _width = Get.width * .16;

//     return Wrap(
//       alignment: WrapAlignment.center,
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 6, left: _width, right: _width),
//           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//           decoration: BoxDecoration(
//             color: colorController.kPrimaryLightColor.withOpacity(.7),
//             borderRadius: const BorderRadius.all(Radius.circular(6)),
//           ),
//           child: _showMessageByNameForGroup(chatMessage: chatMessage),
//         ),
//       ],
//     );
//   }

//   Widget _showMessageByNameForGroup({required ChatMessage chatMessage}) {
//     String _lastMessage = chatMessage.message;

//     final DateTime? _messageDateTime = DateTime.tryParse(_lastMessage);
//     final String _currentUsersName = EmpChatController.to.currentUser!.name;

//     if (_messageDateTime != null) {
//       return _TextMessage(
//           message: _lastMessage.formatDateTime(
//               newDateTimeFormat: kDateDisplayFormat));
//     } else {
//       if (chatMessage.fromUid == EmpChatController.to.currentUser!.uid) {
//         _lastMessage = '$kYou $_lastMessage';

//         return _TextMessage(message: _lastMessage);
//       } else {
//         _lastMessage = _lastMessage
//             .replaceAll('  ', ' ')
//             .replaceAll(_currentUsersName, kYou);
//         _lastMessage = '${chatMessage.fromName} $_lastMessage';

//         return _TextMessage(message: _lastMessage);
//       }
//     }
//   }
// }

// class _TextMessage extends StatelessWidget {
//   final String message;

//   const _TextMessage({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       message,
//       textAlign: TextAlign.center,
//       style: textStyle12Normal.copyWith(fontSize: 10, color: Colors.white),
//     );
//   }
// }
