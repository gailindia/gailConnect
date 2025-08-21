// // Created By Amit Jangid on 28/12/21

// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gail_connect/models/chat_user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gail_connect/utils/constants/firebase_constants.dart';

// class EmpChatController extends GetxController {
//   static EmpChatController get to => Get.find<EmpChatController>();

//   ChatUser? currentUser;

//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

//   @override
//   void onInit() {
//     super.onInit();

//     // calling get current chat user method
//     getCurrentChatUser();
//   }

//   getCurrentChatUser() async {
//     final QuerySnapshot? _querySnapshot =
//         await firestore.collection(kUsersCollection).where(kKeyUid, isEqualTo: firebaseAuth.currentUser!.uid).get();

//     if (_querySnapshot != null && _querySnapshot.size > 0 && _querySnapshot.docs.isNotEmpty) {
//       currentUser = _querySnapshot.docs.map((_userDocument) => ChatUser.fromDoc(_userDocument)).toList().single;

//       if (currentUser == null) {
//         // calling get current chat user method
//         await getCurrentChatUser();
//       }
//     } else {
//       // calling get current chat user method
//       await getCurrentChatUser();
//     }
//   }
// }
