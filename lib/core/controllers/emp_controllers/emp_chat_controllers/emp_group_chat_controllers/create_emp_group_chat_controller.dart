// // Created By Amit Jangid on 27/12/21

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:secure_shared_preferences/secure_shared_pref.dart';
// import 'package:uuid/uuid.dart';
// import 'package:gail_connect/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:gail_connect/config/routes.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gail_connect/models/chat_message.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gail_connect/models/emp_group_info.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
// import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';
// import 'package:gail_connect/core/controllers/main_dash_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_controller.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_chat_controllers/emp_chat_room_controller.dart';

// class CreateEmpGroupChatController extends GetxController {
//   final String _tag = 'CreateEmpGroupChatController';

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final ScrollController scrollController = ScrollController();

//   final TextEditingController groupNameController = TextEditingController();
//   final TextEditingController searchEmpController = TextEditingController();

//   String? title;
//   String _groupId = '', _groupIcon = '';
//   bool isLoading = false,
//       addMembers = false,
//       isImageUploading = false,
//       selectAllMembers = false;

//   File? selectedGroupIconFile;

//   List<EmpGroupInfo> _empGroupInfoList = [];
//   List<ChatUser> chatUserList = [],
//       newGroupMembersList = [],
//       selectedChatUserList = [],
//       filteredChatUserList = [];

//   final FirebaseFirestore _firebaseFirestore = EmpChatController.to.firestore;
//   final FirebaseStorage _firebaseStorage = EmpChatController.to.firebaseStorage;

//   @override
//   void onInit() {
//     super.onInit();

//     title = Get.arguments[kGroupName];
//     _groupId = Get.arguments[kGroupId] ?? '';
//     addMembers = Get.arguments[kAddMembers] ?? false;
//     chatUserList = Get.arguments[kChatUsersList] ?? <ChatUser>[];
//     selectedChatUserList =
//         Get.arguments[kSelectedChatUsersList] ?? <ChatUser>[];

//     // calling get non group members list method
//     _getNonGroupMembersList();

//     // calling get all groups method
//     _getAllGroups();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     // GailConnectServices.to.hitCountApi(activity: kSelectContactForGroupScreen);
//   }

//   _getNonGroupMembersList() async {
//     if (selectedChatUserList.isNotEmpty) {
//       final List<String> _groupUsersUid = [];

//       for (final ChatUser _chatUser in selectedChatUserList) {
//         _groupUsersUid.add(_chatUser.uid);
//       }

//       filteredChatUserList = (await _firebaseFirestore
//               .collection(kUsersCollection)
//               .where(kKeyUid, whereNotIn: _groupUsersUid)
//               .get())
//           .docs
//           .map<ChatUser>((_userDocument) => ChatUser.fromDoc(_userDocument))
//           .toList();

//       update([kNewGroup]);
//     } else {
//       filteredChatUserList = chatUserList;
//       update([kNewGroup]);
//     }
//   }

//   _getAllGroups() async {
//     final QuerySnapshot _empGroupInfoSnapshot = await _firebaseFirestore
//         .collection(kGroupsCollection)
//         .where(kKeyGroupCreatedBy,
//             isEqualTo: EmpChatController.to.currentUser!.uid)
//         .get();

//     _empGroupInfoList = _empGroupInfoSnapshot.docs
//         .map<EmpGroupInfo>((_groupDoc) => EmpGroupInfo.fromDoc(_groupDoc))
//         .toList();

//     for (final ChatUser _chatUser in chatUserList) {
//       _chatUser.isUserSelected = false;
//       update([kNewGroup]);
//     }
//   }

//   _scrollToEnd() async {
//     await Future.delayed(const Duration(milliseconds: 400));

//     scrollController.animateTo(
//       scrollController.position.maxScrollExtent,
//       curve: Curves.easeOut,
//       duration: const Duration(milliseconds: 400),
//     );
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
//       update([kNewGroup]);
//     } else {
//       filteredChatUserList = chatUserList;
//       update([kNewGroup]);
//     }
//   }

//   clearEmployeeSearch() {
//     searchEmpController.clear();

//     // calling search employee method
//     searchEmployee('');
//   }

//   onEmpAdded({required ChatUser chatUser}) {
//     bool _isAlreadyExists = false;

//     for (final ChatUser _chatUser in selectedChatUserList) {
//       if (_chatUser.uid == chatUser.uid) {
//         _isAlreadyExists = true;
//       }
//     }

//     if (!_isAlreadyExists) {
//       chatUser.isUserSelected = true;
//       newGroupMembersList.add(chatUser);
//       selectedChatUserList.add(chatUser);

//       // calling clear employee search method
//       clearEmployeeSearch();

//       // calling scroll to end method
//       _scrollToEnd();
//     }
//   }

//   onEmpRemoved({required int position, required ChatUser chatUser}) async {
//     chatUser.isUserSelected = false;
//     selectedChatUserList.removeAt(position);
//     update([kNewGroup]);
//   }

//   onSelectAllCheckBoxChecked() {
//     selectAllMembers = !selectAllMembers;

//     for (final ChatUser _chatUser in filteredChatUserList) {
//       _chatUser.isUserSelected = selectAllMembers;

//       if (selectAllMembers) {
//         // calling on emp added method
//         onEmpAdded(chatUser: _chatUser);
//       } else {
//         for (int i = 0; i < selectedChatUserList.length; i++) {
//           // calling on emp removed method
//           onEmpRemoved(position: i, chatUser: selectedChatUserList[i]);
//         }
//       }
//     }

//     update([kCreateGroup]);
//   }

//   onChatUserCheckBoxChecked({bool? value, required ChatUser chatUser}) {
//     chatUser.isUserSelected = !chatUser.isUserSelected;

//     if (value != null && value) {
//       onEmpAdded(chatUser: chatUser);
//     } else {
//       for (int i = 0; i < selectedChatUserList.length; i++) {
//         if (chatUser.uid == selectedChatUserList[i].uid) {
//           onEmpRemoved(position: i, chatUser: selectedChatUserList[i]);
//         }
//       }
//     }
//   }

//   navigateToEnterGroupNameScreen() {
//     Get.toNamed(
//       kCreateEmpGroupChatEnterNameRoute,
//       arguments: {
//         kChatUsersList: chatUserList,
//         kSelectedChatUsersList: selectedChatUserList
//       },
//     );
//   }

//   chooseGroupIcon() async {
//     final XFile? _selectedImage = await ImagePicker()
//         .pickImage(imageQuality: 50, source: ImageSource.gallery);

//     if (_selectedImage != null) {
//       isImageUploading = true;
//       update([kNewGroup]);

//       selectedGroupIconFile = File(_selectedImage.path);
//     }
//   }

//   _uploadImageToFirebaseStorage() async {
//     final String _fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     final Reference _ref =
//         _firebaseStorage.ref().child(kKeyGroupIcons).child(_fileName);
//     final UploadTask _uploadTask = _ref.putFile(selectedGroupIconFile!);

//     try {
//       final TaskSnapshot _taskSnapshot = await _uploadTask;
//       _groupIcon = await _taskSnapshot.ref.getDownloadURL();

//       isImageUploading = false;
//       update([kNewGroup]);

//     } on FirebaseException catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg:
//             'exception while uploading group icon to firebase storage',
//       );
//     }
//   }

//   createNewGroup() async {
//     SecureSharedPref pref = await SecureSharedPref.getInstance();
//     try {
//       if (formKey.currentState!.validate()) {
//         formKey.currentState!.save();

//         bool _isGroupAlreadyExists = false;
//         final String _groupName = groupNameController.value.text;

//         for (final EmpGroupInfo _empGroupInfo in _empGroupInfoList) {
//           if (_empGroupInfo.groupName.toLowerCase().replaceAll(' ', '') ==
//               _groupName.toLowerCase().replaceAll(' ', '')) {
//             _isGroupAlreadyExists = true;
//           }
//         }

//         if (_isGroupAlreadyExists) {
//           // calling show custom dialog box method
//           showCustomDialogBox(
//             title: kInfo,
//             context: Get.context!,
//             description: 'A group with $_groupName already exits',
//           );

//           return;
//         }

//         // calling show progress dialog method
//         await showProgressDialog(Get.context!);

//         if (selectedGroupIconFile != null) {
//           // calling upload image to firebase storage
//           await _uploadImageToFirebaseStorage();
//         }

//         final String _groupId = const Uuid().v1();
//         const String _message = "created this group.";
//         String? notiTokenId = await pref.getString("notificationTokenId",isEncrypted: true);
//         final ChatUser _currentChatUser = ChatUser(
//           isAdmin: true,
//           profileUrl: '',
//           status: kOnline,
//           lastMessage: '',
//           isGroupChat: true,
//           lastMessageBy: '',
//           lastMessageByName: '',
//           chatRoomOrGroupId: _groupId,
//           lastMessageTime: Timestamp.now(),
//           uid: EmpChatController.to.currentUser!.uid,
//           cpf: MainDashController.to.loggedInEmployee!.empNo!,
//           name: MainDashController.to.loggedInEmployee!.empName!,
//           email: MainDashController.to.loggedInEmployee!.emails!,
//           notificationTokenId: notiTokenId??"",
//         );

//         // adding current user to the selected user's list as admin
//         // other users will be added as normal users
//         selectedChatUserList.add(_currentChatUser);
//         final List<Map<String, dynamic>> _selectedUsersMapList = [];

//         for (final ChatUser _user in selectedChatUserList) {
//           _selectedUsersMapList.add(_user.toGroupMap());
//         }

//         if (selectedChatUserList.length >= 2) {
//           final EmpGroupInfo _empGroupInfo = EmpGroupInfo(
//             groupId: _groupId,
//             groupName: _groupName,
//             groupIcon: _groupIcon,
//             lastMessage: _message,
//             createDate: Timestamp.now(),
//             createdBy: _currentChatUser.uid,
//             lastMessageTime: Timestamp.now(),
//             lastMessageBy: _currentChatUser.uid,
//             createdByName: _currentChatUser.name,
//             membersMapList: _selectedUsersMapList,
//             lastMessageByName: _currentChatUser.name,
//           );

//           // here group will be created with the generated group id and all the selected members
//           await _firebaseFirestore
//               .collection(kGroupsCollection)
//               .doc(_groupId)
//               .set(_empGroupInfo.toMap());

//           // creating first chat message of group creation with name of the user
//           final ChatMessage _chatMessage = ChatMessage(
//             isAdmin: true,
//             msgSeen: false,
//             message: _message,
//             timestamp: Timestamp.now(),
//             msgType: MessageType.notify,
//             fromUid: _currentChatUser.uid,
//             fromName: _currentChatUser.name,
//           );

//           // here we will store our first chat message of group creation
//           await _firebaseFirestore
//               .collection(kGroupsCollection)
//               .doc(_groupId)
//               .collection(kChatsCollection)
//               .doc(DateTime.now().millisecondsSinceEpoch.toString())
//               .set(_chatMessage.toGroupMap());

//           for (final ChatUser _chatUser in selectedChatUserList) {
//             final String _userUid = _chatUser.uid;

//             final ChatUser _groupChatUser = ChatUser(
//               name: _groupName,
//               isGroupChat: true,
//               uid: _chatUser.uid,
//               cpf: _chatUser.cpf,
//               lastMessage: _message,
//               email: _chatUser.email,
//               profileUrl: _groupIcon,
//               status: _chatUser.status,
//               isAdmin: _chatUser.isAdmin,
//               chatRoomOrGroupId: _groupId,
//               lastMessageTime: Timestamp.now(),
//               lastMessageBy: EmpChatController.to.currentUser!.uid,
//               notificationTokenId: notiTokenId??"",
//               lastMessageByName: EmpChatController.to.currentUser!.name,
//             );

//             // here group info will be added against each users chat list
//             await _firebaseFirestore
//                 .collection(kUsersCollection)
//                 .doc(_userUid)
//                 .collection(kChatListCollection)
//                 .doc(_groupId)
//                 .set(_groupChatUser.toMap());
//           }
//         }

//         // calling hide progress dialog method
//         await hideProgressDialog();

//         Get.back();
//         Get.back();
//       }
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg: 'exception while creating group for in app chatting',
//       );
//     }
//   }

//   addNewMemberToGroup() async {
//     SecureSharedPref pref = await SecureSharedPref.getInstance();

//     try {
//       if (newGroupMembersList.isEmpty) {
//         // calling show custom dialog box method
//         showCustomDialogBox(
//             context: Get.context!,
//             title: kInfo,
//             description: kMsgSelectNewMembersToAddMembers);

//         return;
//       }

//       // calling show progress dialog method
//       await showProgressDialog(Get.context!);
//       String _newMembersName = '';

//       for (final ChatUser _chatUser in newGroupMembersList) {
//         _newMembersName += _chatUser.name + ', ';
//       }

//       _newMembersName =
//           _newMembersName.substring(0, _newMembersName.length - 2);

//       final List<Map<String, dynamic>> _newGroupMembersMapList = [];
//       final String _message = "added $_newMembersName to the Group.";

//       for (final ChatUser _user in selectedChatUserList) {
//         _newGroupMembersMapList.add(_user.toGroupMap());
//       }

//       // here we are updating
//       await _firebaseFirestore
//           .collection(kGroupsCollection)
//           .doc(_groupId)
//           .update({kKeyMembers: _newGroupMembersMapList});

//       // here we are getting group info
//       final DocumentSnapshot _empGroupInfoDoc = await _firebaseFirestore
//           .collection(kGroupsCollection)
//           .doc(_groupId)
//           .get();

//       final EmpGroupInfo _empGroupInfo = EmpGroupInfo.fromDoc(_empGroupInfoDoc);
//       String? notiTokenId = await pref.getString("notificationTokenId",isEncrypted: true);

//       for (final ChatUser _chatUser in newGroupMembersList) {
//         final String _userUid = _chatUser.uid;

//         final ChatUser _groupChatUser = ChatUser(
//           isGroupChat: true,
//           uid: _chatUser.uid,
//           cpf: _chatUser.cpf,
//           lastMessage: _message,
//           email: _chatUser.email,
//           status: _chatUser.status,
//           isAdmin: _chatUser.isAdmin,
//           chatRoomOrGroupId: _groupId,
//           name: _empGroupInfo.groupName,
//           lastMessageTime: Timestamp.now(),
//           profileUrl: _empGroupInfo.groupIcon,
//           lastMessageBy: EmpChatController.to.currentUser!.uid,
//           notificationTokenId: notiTokenId??"",
//           lastMessageByName: EmpChatController.to.currentUser!.name,
//         );

//         // here group info will be added against each users
//         await _firebaseFirestore
//             .collection(kUsersCollection)
//             .doc(_userUid)
//             .collection(kChatListCollection)
//             .doc(_groupId)
//             .set(_groupChatUser.toMap());
//       }

//       // creating first chat message of group creation with name of the user
//       final ChatMessage _chatMessage = ChatMessage(
//         isAdmin: true,
//         msgSeen: false,
//         message: _message,
//         timestamp: Timestamp.now(),
//         msgType: MessageType.notify,
//         fromUid: EmpChatController.to.currentUser!.uid,
//         fromName: EmpChatController.to.currentUser!.name,
//       );

//       // here we will store our first chat message of group creation
//       await _firebaseFirestore
//           .collection(kGroupsCollection)
//           .doc(_groupId)
//           .collection(kChatsCollection)
//           .doc(DateTime.now().millisecondsSinceEpoch.toString())
//           .set(_chatMessage.toGroupMap());

//       final ChatUser _currentChatUser = ChatUser(
//         uid: '',
//         cpf: '',
//         email: '',
//         status: '',
//         isAdmin: true,
//         isGroupChat: true,
//         lastMessage: _message,
//         chatRoomOrGroupId: _groupId,
//         name: _empGroupInfo.groupName,
//         lastMessageTime: Timestamp.now(),
//         profileUrl: _empGroupInfo.groupIcon,
//         lastMessageBy: EmpChatController.to.currentUser!.uid,
//         notificationTokenId: notiTokenId??"",
//         lastMessageByName: EmpChatController.to.currentUser!.name,
//       );

//       await _firebaseFirestore
//           .collection(kUsersCollection)
//           .doc(EmpChatController.to.currentUser!.uid)
//           .collection(kChatListCollection)
//           .doc(_groupId)
//           .update(_currentChatUser.toChatListMap(_message));

//       // calling hide progress dialog method
//       await hideProgressDialog();

//       Get.back();
//       Get.back();
//     } catch (e, s) {
//       handleException(
//         exception: e,
//         stackTrace: s,
//         exceptionClass: _tag,
//         exceptionMsg:
//             'exception while adding new member to the group for in app chatting',
//       );

//       // calling hide progress dialog method
//       await hideProgressDialog();
//     }
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     searchEmpController.dispose();

//     super.dispose();
//   }
// }
