// import 'package:flutter/material.dart';
// import 'package:gail_connect/ui/styles/colors.dart';

// class NotificationDetailsScreen extends StatefulWidget {
//   const NotificationDetailsScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationDetailsScreen> createState() =>
//       _NotificationDetailsScreenState();
// }

// class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color:
//             kDarkGreyColor // isko page main.dart me onesignal me homescreen se replace kr dena,
//         //notification aaye to tap krne pr ye page khule
//         );
//   }
// }
// Created By Amit Jangid 20/10/21

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/notification_controller.dart';

import 'package:gail_connect/models/notification_model.dart';
import 'package:gail_connect/ui/widgets/notification_card.dart';
import 'package:get/get.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class NotificationDetailsScreen extends StatelessWidget {
  final String image, title, content;
  const NotificationDetailsScreen(
      {
        required this.image,
      required this.title,
      required this.content,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WhatsNewController whatsNewController = Get.put(WhatsNewController());

    return Scaffold(
        // appBar: CustomAppBar(title: kNotificationTitle),
        body: GetBuilder<NotificationController>(
      id: kNotificationTitle,
      init: NotificationController(),
      builder: (_controller) {
        return Scaffold(
          appBar: CustomAppBar(title: kNotificationTitle),
          body: _controller.isLoading
              ? const LoadingWidget()
              : _controller.notificationList.isNotEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.1, 0.7],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                          colors: [
                            Color.fromARGB(255, 192, 221, 252),
                            Color.fromARGB(255, 228, 223, 208),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(14),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: _controller.notificationList.length,
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, bottom: 48),
                        itemBuilder: (context, _position) {
                          final NotificationModel _notificationDetails =
                              _controller.notificationList[_position];
                          return NotificationCardWidget(
                            content: content,
                            title: title,
                            image:
                                // "https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/" +
                                image,
                            // "https://c.ndtvimg.com/2020-08/hgfc9108_kohli-twitter_625x300_18_August_20.jpg?output-quality=80&downsize=1278:*",
                          );
                        },
                      ),
                    )
                  : const NoRecordsFound(),
        );
      },
    ));
  }
}
