// Created By Amit Jangid 20/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/banner_details.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:multiutillib/animations/slide_animation.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gail_connect/ui/widgets/network_image_widget.dart';
import 'package:gail_connect/core/controllers/banner_details_controller.dart';

class BannersDetailsScreen extends StatelessWidget {
  const BannersDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BannerDetailsController>(
        id: kBannerDetails,
        init: BannerDetailsController(),
        builder: (_bannerDetController) {
          return Scaffold(
            appBar: CustomAppBar(title: _bannerDetController.screenTitle ?? kBannerDetails),
            body: _bannerDetController.isLoading
                ? const LoadingWidget()
                : _bannerDetController.bannerDetailsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _bannerDetController.bannerDetailsList.length,
                        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 48),
                        itemBuilder: (context, _position) {
                          final BannerDetails _bannerDetails = _bannerDetController.bannerDetailsList[_position];

                          return SlideAnimation(
                            position: _position,
                            itemCount: _bannerDetController.bannerDetailsList.length,
                            animationController: _bannerDetController.animationController,
                            child: Stack(
                              children: [
                                NetworkImageWidget(width: double.infinity, imageUrl: _bannerDetails.image!),
                                Positioned(
                                  right: 6,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: InkWell(
                                      // calling download and share image method
                                      onTap: () => _bannerDetController.downloadAndShareImage(
                                        imageUrl: _bannerDetails.image!,
                                        title: _bannerDetController.screenTitle!,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      child: const Icon(MaterialCommunityIcons.share, size: 36),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const NoRecordsFound(),
          );
        },
      ),
    );
  }
}
