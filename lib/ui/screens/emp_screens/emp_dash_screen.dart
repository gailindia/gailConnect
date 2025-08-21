// // Created By Amit Jangid on 17/12/21

// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
// import 'package:get/get.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:gail_connect/core/controllers/emp_controllers/emp_dash_controller.dart';

// import '../../styles/color_controller.dart';

// class EmpDashScreen extends StatelessWidget {
//   const EmpDashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // ColorController colorController= Get.put(ColorController());
//     EmpDashController _empDashController= Get.put(EmpDashController());
//     return GetBuilder<ColorController>(
//       id: kEmpDash,
//       init: ColorController(),
//       builder: (colorController) => Scaffold(
//         appBar: CustomAppBar(title: 'Employees',),
//         body: _empDashController
//             .bottomNavChildren[_empDashController.currentIndex],
//         // bottomNavigationBar: BottomNavigationBar(
//         //   selectedFontSize: 15,
//         //   unselectedFontSize: 14,
//         //   showSelectedLabels: false,
//         //   showUnselectedLabels: false,
//         //   backgroundColor: kPrimaryColor,
//         //   selectedItemColor: Colors.white,
//         //   unselectedItemColor: Colors.grey,
//         //   // calling on bottom nav tapped method
//         //   onTap: _fmsDashController.onBottomNavTapped,
//         //   currentIndex: _fmsDashController.currentIndex,
//         //   items: const [
//         //     BottomNavigationBarItem(label: '', icon: Icon(Feather.user)),
//         //     BottomNavigationBarItem(label: '', icon: Icon(Feather.users)),
//         //     BottomNavigationBarItem(label: '', icon: Icon(Entypo.chat)),
//         //   ],
//         // ),

//        /* bottomNavigationBar: BottomNavyBar(
//           items: <BottomNavyBarItem>[
//             BottomNavyBarItem(
//               icon: const Icon(Feather.user),
//               title: const Text(
//                 'Employees',
//                 textAlign: TextAlign.center,
//               ),
//               activeColor: const Color.fromARGB(255, 234, 234, 234),
//             ),
//             // BottomNavyBarItem(
//             //   icon: const Icon(Feather.users),
//             //   title: const Text(
//             //     'Groups',
//             //     textAlign: TextAlign.center,
//             //   ),
//             //   activeColor: const Color.fromARGB(255, 227, 227, 227),
//             // ),
//             BottomNavyBarItem(
//               icon: const Icon(Entypo.chat),
//               title: const Text(
//                 'Chats',
//                 textAlign: TextAlign.center,
//               ),
//               activeColor: const Color.fromARGB(255, 226, 226, 226),
//             ),
//           ],
//           onItemSelected: _empDashController.onBottomNavTapped,
//           selectedIndex: _empDashController.currentIndex,
//           containerHeight: 65,
//           backgroundColor: colorController.kPrimaryColor,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//         ),*/
//       ),
//     );
//   }
// }
