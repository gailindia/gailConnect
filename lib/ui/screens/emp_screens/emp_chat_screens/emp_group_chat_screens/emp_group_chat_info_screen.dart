// // Created By Amit Jangid on 28/12/21

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/utils/utils.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/loading_widget.dart';
// import 'package:multiutillib/widgets/rich_text_widgets.dart';
// import 'package:gail_connect/ui/widgets/primary_button.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/ui/screens/full_image_screen.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/open_container_transition.dart';
// import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_group_chat_controllers/emp_group_chat_info_controller.dart';

// class EmpGroupChatInfoScreen extends StatelessWidget {
//   const EmpGroupChatInfoScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  CustomAppBar(title: kGroupDetails),
//       body: GetBuilder<EmpGroupChatInfoController>(
//         id: kEmpGroupDetails,
//         init: EmpGroupChatInfoController(),
//         builder: (_controller) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 48),
//             child: StreamBuilder<DocumentSnapshot>(
//               stream: _controller.empGroupInfoStream,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const LoadingWidget();
//                 }

//                 _controller.empGroupInfo = EmpGroupInfo.fromDoc(snapshot.data);

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     MaterialCard(
//                       child: Column(
//                         children: [
//                           OpenContainerTransition(
//                             tappable: (_controller.empGroupInfo.groupIcon.isNotEmpty),
//                             closedBuilder: (context, action) {
//                               return Stack(
//                                 children: [
//                                   CircularNetworkImageWidget(
//                                     imageWidth: 140,
//                                     imageHeight: 140,
//                                     showGroupImage: true,
//                                     imageUrl: _controller.empGroupInfo.groupIcon,
//                                   ),
//                                   Positioned(
//                                     right: 0,
//                                     bottom: 0,
//                                     child: InkWell(
//                                       onTap: () => Get.toNamed(
//                                         kUpdateEmpGroupChatIconNameRoute,
//                                         arguments: _controller.empGroupInfo,
//                                       ),
//                                       child: Container(
//                                         width: 60,
//                                         height: 60,
//                                         decoration: const BoxDecoration(
//                                           color: Colors.black38,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(AntDesign.edit),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                             openBuilder: (context, action) {
//                               if (_controller.empGroupInfo.groupIcon.isNotEmpty) {
//                                 return FullImageScreen(
//                                   title: _controller.empGroupInfo.groupName,
//                                   imageUrl: _controller.empGroupInfo.groupIcon,
//                                 );
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             },
//                           ),
//                           verticalSpace18,
//                           Text(_controller.empGroupInfo.groupName, style: textStyle20Bold),
//                           verticalSpace6,
//                           Text('$kMembers: ${_controller.empGroupInfo.groupMembersList.length}',
//                               style: textStyle13Normal),
//                           verticalSpace6,
//                           Text('$kCreatedBy: ${_controller.empGroupInfo.createdByName}', style: textStyle13Normal),
//                           Text(
//                             // calling convert milliseconds to date method
//                             // '$kCreatedOn: ${convertMillisecondsToDate(_controller.empGroupInfo.createDate)}',
//                             '$kCreatedOn: ${convertMillisecondsToDate(_controller.empGroupInfo.createDate)}',
//                             style: textStyle13Normal,
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (_controller.empGroupInfo.createdBy == EmpChatController.to.currentUser!.uid) ...[
//                       PrimaryButton(
//                         text: kAddMembers,
//                         shape: const RoundedRectangleBorder(),
//                         onPressed: _controller.navigateToAddMembersScreen,
//                       ),
//                     ],
//                     if (_controller.empGroupInfo.groupMembersList.isNotEmpty) ...[
//                       MaterialCard(
//                         padding: const EdgeInsets.only(),
//                         child: ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: _controller.empGroupInfo.groupMembersList.length,
//                           separatorBuilder: (context, _position) =>    Divider(height: 2, color: colorController.kPrimaryDarkColor),
//                           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//                           itemBuilder: (context, _position) {
//                             final ChatUser _chatUser = _controller.empGroupInfo.groupMembersList[_position];

//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       OpenContainerTransition(
//                                         tappable: (_chatUser.profileUrl.isNotEmpty),
//                                         closedBuilder: (context, action) => CircularNetworkImageWidget(
//                                           imageUrl: _chatUser.profileUrl,
//                                         ),
//                                         closedShape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(Radius.circular(100)),
//                                         ),
//                                         openBuilder: (context, action) {
//                                           if (_chatUser.profileUrl.isNotEmpty) {
//                                             return FullImageScreen(
//                                               title: _chatUser.name,
//                                               imageUrl: _chatUser.profileUrl,
//                                             );
//                                           } else {
//                                             return const SizedBox.shrink();
//                                           }
//                                         },
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(_chatUser.name, style: textStyle16Bold),
//                                             verticalSpace6,
//                                             RichTextWidget(
//                                               caption: kCpfNo,
//                                               description: _chatUser.cpf,
//                                               captionStyle: textStyle13Bold,
//                                               descriptionStyle: textStyle13Normal,
//                                             ),
//                                             RichTextWidget(
//                                               caption: kEmailId,
//                                               description: _chatUser.email,
//                                               captionStyle: textStyle13Bold,
//                                               descriptionStyle: textStyle13Normal,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       // calling check if logged in emp is admin for group method
//                                       /*if (_controller.empGroupInfo.createdBy == EmpChatController.to.currentUser!.uid &&
//                                           _chatUser.uid != EmpChatController.to.currentUser!.uid) ...[
//                                         IconButton(
//                                           color: kRedColor,
//                                           padding: const EdgeInsets.only(),
//                                           icon: const Icon(AntDesign.delete),
//                                           onPressed: () {},
//                                           // calling remove member from group method
//                                           // onPressed: () => _controller.removeMemberFromGroup(groupMembers: _employee.empNo!),
//                                         ),
//                                       ],*/
//                                     ],
//                                   ).paddingSymmetric(vertical: 6),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
