// // Created By Amit Jangid on 28/12/21

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gail_connect/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_room_controller.dart';

// class UpdateEmpGroupChatController extends GetxController {
//   final String _tag = 'UpdateEmpGroupChatController';

//   String _groupIcon = '';
//   bool isImageUploading = false;

//   File? selectedGroupIconFile;
//   late EmpGroupInfo empGroupInfo;

//   final TextEditingController groupNameController = TextEditingController();

//   final FirebaseFirestore _firebaseFirestore = EmpChatController.to.firestore;
//   final FirebaseStorage _firebaseStorage = EmpChatController.to.firebaseStorage;

//   @override
//   void onInit() {
//     super.onInit();

//     empGroupInfo = Get.arguments;
//     groupNameController.text = empGroupInfo.groupName;
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kUpdateEmployeeGroupChatInfoScreen);
//   }

//   chooseGroupIcon() async {
//     final XFile? _selectedImage = await ImagePicker()
//         .pickImage(imageQuality: 50, source: ImageSource.gallery);

//     if (_selectedImage != null) {
//       isImageUploading = true;
//       update([kUpdateGroupInfo]);

//       selectedGroupIconFile = File(_selectedImage.path);
//     }
//   }

//   uploadImageToFirebaseStorage() async {
//     if (selectedGroupIconFile != null) {
//       // calling show progress dialog method
//       await showProgressDialog(Get.context!);

//       if (empGroupInfo.groupIcon.isNotEmpty &&
//           empGroupInfo.groupIcon.toLowerCase().contains(
//               'https://firebasestorage.googleapis.com'.toLowerCase())) {
//         final Reference _groupIconRef =
//             _firebaseStorage.refFromURL(empGroupInfo.groupIcon);
//         await _groupIconRef.delete();
//       }

//       final String _fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       final Reference _ref =
//           _firebaseStorage.ref().child(kKeyGroupIcons).child(_fileName);
//       final UploadTask _uploadTask = _ref.putFile(selectedGroupIconFile!);

//       try {
//         final TaskSnapshot _taskSnapshot = await _uploadTask;
//         _groupIcon = await _taskSnapshot.ref.getDownloadURL();

//         isImageUploading = false;
//         update([kUpdateGroupInfo]);

//       } on FirebaseException catch (e, s) {
//         handleException(
//           exception: e,
//           stackTrace: s,
//           exceptionClass: _tag,
//           exceptionMsg:
//               'exception while uploading group icon to firebase storage',
//         );

//         _groupIcon = '';
//         isImageUploading = false;
//         update([kUpdateGroupInfo]);
//       }

//       // calling hide progress dialog method
//       await hideProgressDialog();

//       Get.back();
//     }
//   }

//   updateGroupIconAndName() async {
//     final String _groupName = groupNameController.value.text;

//     // calling upload image to firebase storage method
//     await uploadImageToFirebaseStorage();

//     if (_groupIcon.isNotEmpty) {
//       // calling update group icon and message method
//       await _updateGroupIconAndMessage('updated Group Icon');
//     }

//     if (_groupName.toLowerCase().replaceAll(' ', '') !=
//         empGroupInfo.groupName.toLowerCase().replaceAll(' ', '')) {
//       // calling update group name and message method
//       await _updateGroupNameAndMessage(
//           'changed group name from ${empGroupInfo.groupName} to $_groupName');
//     }
//   }

//   _updateGroupIconAndMessage(String message) async {
//     empGroupInfo.groupIcon = _groupIcon;

//     // calling update group info and message method
//     await _updateGroupInfoAndMessage(message);
//   }

//   _updateGroupNameAndMessage(String message) async {
//     // calling show progress dialog method
//     await showProgressDialog(Get.context!);

//     empGroupInfo.groupName = groupNameController.value.text;

//     // calling update group info and message method
//     await _updateGroupInfoAndMessage(message);

//     // calling hide progress dialog method
//     await hideProgressDialog();

//     Get.back();
//   }

//   _updateGroupInfoAndMessage(String message) async {
//     // here group will be updated with new group name and group icon
//     await _firebaseFirestore
//         .collection(kGroupsCollection)
//         .doc(empGroupInfo.groupId)
//         .update(empGroupInfo.toGroupInfoUpdateMap(message: message));

//     for (final ChatUser _chatUser in empGroupInfo.groupMembersList) {
//       _chatUser.profileUrl = empGroupInfo.groupIcon;

//       // here group info will be added against each users
//       await _firebaseFirestore
//           .collection(kUsersCollection)
//           .doc(_chatUser.uid)
//           .collection(kChatListCollection)
//           .doc(empGroupInfo.groupId)
//           .update(_chatUser.toChatListMap(message));
//     }

//     // creating first chat message of group creation with name of the user
//     final ChatMessage _chatMessage = ChatMessage(
//       msgSeen: false,
//       message: message,
//       timestamp: Timestamp.now(),
//       msgType: MessageType.notify,
//       fromUid: EmpChatController.to.currentUser!.uid,
//       fromName: EmpChatController.to.currentUser!.name,
//       isAdmin: EmpChatController.to.currentUser!.uid == empGroupInfo.createdBy,
//     );

//     // here we will store our first chat message of group creation
//     await _firebaseFirestore
//         .collection(kGroupsCollection)
//         .doc(empGroupInfo.groupId)
//         .collection(kChatsCollection)
//         .doc(DateTime.now().millisecondsSinceEpoch.toString())
//         .set(_chatMessage.toGroupMap());
//   }
// }
