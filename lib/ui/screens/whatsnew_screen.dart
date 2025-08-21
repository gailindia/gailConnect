// Created By Amit Jangid 20/10/21

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/whatsnew_controllers.dart';
import 'package:gail_connect/models/whatsnew_model.dart';
import 'package:gail_connect/ui/widgets/whatsnew_list_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class WhatsNewScreen extends StatelessWidget {
  const WhatsNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WhatsNewController whatsNewController = Get.put(WhatsNewController());

    return Scaffold(
        // appBar: CustomAppBar(title: "WhatsNewDetails"),
        body: GetBuilder<WhatsNewController>(
      id: kWhatsnewTitle,
      init: WhatsNewController(),
      builder: (_controller) {
        return Scaffold(
          appBar:
              CustomAppBar(title: _controller.screenTitle ?? kWhatsnewTitle),
          body: _controller.isLoading
              ? const LoadingWidget()
              : _controller.whatsNewList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _controller.whatsNewList.length,
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, bottom: 48),
                      itemBuilder: (context, _position) {
                        final WhatsNewModel _whatsNewDetails =
                            _controller.whatsNewList[_position];

                        return Stack(
                          children: [
                            Card(
                              child: WhatsNewListWidget(
                                content: _whatsNewDetails.content.toString(),
                                title: _whatsNewDetails.title.toString(),
                                image:
                                    "https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/" +
                                        _whatsNewDetails.image.toString(),
                                // "https://c.ndtvimg.com/2020-08/hgfc9108_kohli-twitter_625x300_18_August_20.jpg?output-quality=80&downsize=1278:*",
                              ),
                            )
                            //   NetworkImageWidget(
                            //       width: double.infinity,
                            //       imageUrl: _bannerDetails.image!),
                            // Positioned(
                            //   right: 6,
                            //   bottom: 0,
                            //   child: Container(
                            //     padding: const EdgeInsets.all(6),
                            //     decoration: const BoxDecoration(
                            //       color: Colors.black12,
                            //       borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(6),
                            //         topRight: Radius.circular(6),
                            //         bottomLeft: Radius.circular(6),
                            //         bottomRight: Radius.circular(12),
                            //       ),
                            //     ),
                            //     child: InkWell(
                            //       // calling download and share image method
                            //       onTap: () => _bannerDetController
                            //           .downloadAndShareImage(
                            //         imageUrl: _bannerDetails.image!,
                            //         title: _bannerDetController.screenTitle!,
                            //       ),
                            //       borderRadius: const BorderRadius.all(
                            //           Radius.circular(100)),
                            //       child: const Icon(
                            //           MaterialCommunityIcons.share,
                            //           size: 36),
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      },
                    )
                  : const NoRecordsFound(),
        );
      },
    ));
  }
}
