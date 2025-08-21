// // Created By Amit Jangid on 28/12/21

// import 'package:get/get.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';

// class EmpGroupChatInfoController extends GetxController {
//   bool isLoading = true;

//   late String groupId;
//   late EmpGroupInfo empGroupInfo;
//   late Stream<DocumentSnapshot> empGroupInfoStream;

//   List<ChatUser> chatUserList = [];

//   final FirebaseFirestore _firestore = EmpChatController.to.firestore;

//   @override
//   void onInit() {
//     super.onInit();

//     groupId = Get.arguments[kGroupId];
//     chatUserList = Get.arguments[kChatUsersList];

//     // calling get group info method
//     getGroupInfo();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kEmployeesGroupChatDetailsScreen);
//   }

//   getGroupInfo() async {
//     isLoading = true;
//     update([kEmpGroupChatRoom]);

//     empGroupInfoStream =
//         _firestore.collection(kGroupsCollection).doc(groupId).snapshots();

//     isLoading = false;
//     update([kEmpGroupDetails]);
//   }

//   navigateToAddMembersScreen() {
//     Get.toNamed(
//       kCreateEmpGroupChatRoute,
//       arguments: {
//         kGroupId: groupId,
//         kAddMembers: true,
//         kChatUsersList: chatUserList,
//         kTitle: empGroupInfo.groupName,
//         kSelectedChatUsersList: empGroupInfo.groupMembersList,
//       },
//     );
//   }
// }
