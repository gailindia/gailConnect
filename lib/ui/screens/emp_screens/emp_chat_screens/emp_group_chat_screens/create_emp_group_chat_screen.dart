// // Created By Amit Jangid on 27/12/21

// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_group_chat_controllers/create_emp_group_chat_controller.dart';
// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:multiutillib/widgets/loading_widget.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:multiutillib/widgets/rich_text_widgets.dart';

// import '../../../../styles/color_controller.dart';

// class CreateEmpGroupChatScreen extends StatelessWidget {
//   const CreateEmpGroupChatScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController= Get.put(ColorController());
//     return GetBuilder<CreateEmpGroupChatController>(
//       id: kNewGroup,
//       init: CreateEmpGroupChatController(),
//       builder: (_controller) {
//         return Scaffold(
//           appBar:  CustomAppBar(title: kNewGroupAddMembers),
//           floatingActionButton: (_controller.selectedChatUserList.isNotEmpty || _controller.selectAllMembers)
//               ? FloatingActionButton(
//                   tooltip: kNext,
//                   clipBehavior: Clip.antiAlias,
//                   backgroundColor: colorController.kPrimaryDarkColor,
//                   child: const Icon(Ionicons.add, size: 36),
//                   onPressed: () {
//                     if (_controller.addMembers) {
//                       // calling add new member to group method
//                       _controller.addNewMemberToGroup();
//                     } else {
//                       // calling navigate to enter group name screen method
//                       _controller.navigateToEnterGroupNameScreen();
//                     }
//                   },
//                 )
//               : null,
//           body: Column(
//             children: [
//               MaterialCard(
//                 borderRadius: 12,
//                 padding: const EdgeInsets.only(),
//                 margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         autocorrect: false,
//                         enableSuggestions: false,
//                         // calling search employee method
//                         onChanged: _controller.searchEmployee,
//                         controller: _controller.searchEmpController,
//                         decoration:  InputDecoration(
//                           border: InputBorder.none,
//                           hintText: kEnterEmpNameCpf,
//                           hintStyle: textStyle13Normal,
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     if (_controller.searchEmpController.value.text.isNotEmpty) ...[
//                       IconButton(
//                         color: colorController.kBlackShadeColor,
//                         icon: const Icon(MaterialIcons.clear),
//                         // calling clear employee search method
//                         onPressed: () => _controller.clearEmployeeSearch(),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               verticalSpace12,
//               MaterialCard(
//                 borderRadius: 12,
//                 margin: const EdgeInsets.symmetric(horizontal: 12),
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                 child: Row(
//                   children: [
//                      Expanded(child: Text(kSelectAll, style: textStyle14Normal)),
//                     horizontalSpace12,
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Checkbox(
//                           value: _controller.selectAllMembers,
//                           visualDensity: VisualDensity.compact,
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           // calling on select all check box checked method
//                           onChanged: (_value) => _controller.onSelectAllCheckBoxChecked(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (_controller.selectedChatUserList.isNotEmpty) ...[
//                 SizedBox(
//                   height: 110,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     controller: _controller.scrollController,
//                     padding: const EdgeInsets.only(right: 12),
//                     itemCount: _controller.selectedChatUserList.length,
//                     itemBuilder: (context, _position) {
//                       final ChatUser _chatUser = _controller.selectedChatUserList[_position];

//                       return Stack(
//                         children: [
//                           SizedBox(
//                             width: 80,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const CircularNetworkImageWidget(imageUrl: ''),
//                                 Text(
//                                   _chatUser.name,
//                                   maxLines: 2,
//                                   style: textStyle12Normal,
//                                   textAlign: TextAlign.center,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             right: 0,
//                             bottom: 6,
//                             child: InkWell(
//                               // calling on selected employee removed method
//                               onTap: () => _controller.onEmpRemoved(position: _position, chatUser: _chatUser),
//                               child: Container(
//                                 padding: const EdgeInsets.all(3),
//                                 decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
//                                 child: const Icon(MaterialIcons.clear, size: 24),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//               if (_controller.isLoading) ...[
//                 const Expanded(child: LoadingWidget()),
//               ] else if (_controller.filteredChatUserList.isNotEmpty) ...[
//                 verticalSpace12,
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _controller.filteredChatUserList.length,
//                     padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
//                     itemBuilder: (context, _position) {
//                       final ChatUser _chatUser = _controller.filteredChatUserList[_position];

//                       return MaterialCard(
//                         borderRadius: 12,
//                         margin: const EdgeInsets.only(bottom: 12),
//                         // calling on emp added method
//                         onTap: () => _controller.onEmpAdded(chatUser: _chatUser),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const CircularNetworkImageWidget(imageUrl: ''),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(_chatUser.name, style: textStyle16Bold),
//                                         verticalSpace6,
//                                         RichTextWidget(
//                                           caption: kCpfNo,
//                                           description: _chatUser.cpf,
//                                           captionStyle: textStyle13Bold,
//                                           descriptionStyle: textStyle13Normal,
//                                         ),
//                                         RichTextWidget(
//                                           caption: kEmailId,
//                                           description: _chatUser.email,
//                                           captionStyle: textStyle13Bold,
//                                           descriptionStyle: textStyle13Normal,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Checkbox(
//                               value: _chatUser.isUserSelected,
//                               visualDensity: VisualDensity.compact,
//                               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               onChanged: (_value) => _controller.onChatUserCheckBoxChecked(
//                                 value: _value,
//                                 chatUser: _chatUser,
//                               ),
//                               // calling on emp added method
//                               // onChanged: (_value) => _controller.onEmpAdded(chatUser: _chatUser),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
