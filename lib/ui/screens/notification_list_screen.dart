import 'package:flutter/material.dart';
import 'package:gail_connect/models/notification_model.dart';
import 'package:gail_connect/ui/screens/notification_detail_screen.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import '../../core/controllers/notification_controller.dart';
import '../widgets/custom_app_bar.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

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
                          return GestureDetector(
                            onTap: () {
                              Get.to(NotificationDetailsScreen(
                                  image:
                                      _notificationDetails.imageUrl.toString(),
                                  title: _notificationDetails.title.toString(),
                                  content:
                                      _notificationDetails.message.toString())
                                  );
                            },
                            child: MaterialCard(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                    _notificationDetails.imageUrl.toString(),
                                    width: MediaQuery.of(context).size.width *
                                        .25),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .60,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _notificationDetails.title.toString(),
                                          maxLines: 4,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            _notificationDetails.CREATED_ON
                                                .toString(),
                                            maxLines: 4,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                          );

                          // NotificationCardWidget(
                          //   content: _notificationDetails.message.toString(),
                          //   title: _notificationDetails.title.toString(),
                          //   image:
                          //       // "https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/" +
                          //       _notificationDetails.imageUrl.toString(),
                          //   // "https://c.ndtvimg.com/2020-08/hgfc9108_kohli-twitter_625x300_18_August_20.jpg?output-quality=80&downsize=1278:*",
                          // );
                        },
                      ),
                    )
                  : const NoRecordsFound(),
        );
      },
    ));
  }
}
