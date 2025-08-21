// // Created By Amit Jangid on 23/12/21

// import 'package:flutter/material.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/ui/widgets/primary_icon_button.dart';
// import 'package:get/get.dart';

// import 'package:multiutillib/utils/ui_helpers.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:multiutillib/widgets/material_card.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:multiutillib/widgets/loading_widget.dart';
// import 'package:multiutillib/widgets/rich_text_widgets.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/select_emp_controller.dart';

// import '../../../styles/color_controller.dart';

// class SelectEmpScreen extends StatelessWidget {
//   const SelectEmpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ColorController colorController= Get.put(ColorController());
//     return GetBuilder<SelectEmpController>(
//       id: kSelectContact,
//       init: SelectEmpController(),
//       builder: (_controller) {
//         return Scaffold(
//           appBar:  CustomAppBar(title: kSelectContact),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
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
//                         controller: _controller.searchEmployeeController,
//                         decoration:  InputDecoration(
//                           border: InputBorder.none,
//                           hintText: kEnterEmpNameCpf,
//                           hintStyle: textStyle13Normal,
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     if (_controller.searchEmployeeController.value.text.isNotEmpty) ...[
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
//               PrimaryIconButton(
//                 text: kNewGroup,
//                 icon: MaterialIcons.group,
//                 margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
//                 onPressed: () => Get.offNamed(
//                   kCreateEmpGroupChatRoute,
//                   arguments: {kChatUsersList: _controller.chatUserList, kSelectedChatUsersList: <ChatUser>[]},
//                 ),
//               ),
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
//                         // calling navigate to chat room
//                         onTap: () => _controller.navigateToChatRoom(chatUser: _chatUser),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const CircularNetworkImageWidget(imageUrl: ''),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(_chatUser.name, style: textStyle16Bold),
//                                   verticalSpace6,
//                                   RichTextWidget(
//                                     caption: kCpfNo,
//                                     description: _chatUser.cpf,
//                                     captionStyle: textStyle13Bold,
//                                     descriptionStyle: textStyle13Normal,
//                                   ),
//                                   RichTextWidget(
//                                     caption: kEmailId,
//                                     description: _chatUser.email,
//                                     captionStyle: textStyle13Bold,
//                                     descriptionStyle: textStyle13Normal,
//                                   ),
//                                 ],
//                               ),
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
