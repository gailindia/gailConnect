// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/icon_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/news_controllers/news_controller.dart';

import '../../styles/color_controller.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: kNews),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 36),
        child: GetBuilder<NewsController>(
          builder: (_newsController) {
            _newsController.animationController.forward();
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconWidget(
                        title: kGailNews,
                        iconColor: colorController.kPrimaryColor,
                        icon: FontAwesome.newspaper_o,
                        scale: _newsController.animation,
                        // calling on news category selected method
                        onTap: () => _newsController.onNewsCategorySelected(
                          listTitle: kGailNews,
                          category: kNewsCategoryG,
                          hitCountScreen: kGailNewsScreen,
                        ),
                      ),
                      horizontalSpace12,
                      IconWidget(
                        icon: Entypo.news,
                        title: kIndustryNews,
                        iconColor: colorController.kPrimaryColor,
                        scale: _newsController.animation,
                        // calling on news category selected method
                        onTap: () => _newsController.onNewsCategorySelected(
                          category: kNewsCategoryI,
                          listTitle: kIndustryNews,
                          hitCountScreen: kIndustryNewsScreen,
                        ),
                      ),
                    ],
                  ),
                  // verticalSpace12,
                  // Row(
                  //   children: [
                  //     /*IconWidget(
                  //       title: kLiveEvents,
                  //       iconColor: kPurpleColor,
                  //       icon: MaterialIcons.event_note,
                  //       scale: _newsController.animation,
                  //       // calling navigate to live events screen method
                  //       onTap: () => _newsController.navigateToLiveEventsScreen(),
                  //     ),
                  //     horizontalSpace12,*/
                  //     IconWidget(
                  //       title: kTwitter,
                  //       icon: AntDesign.twitter,
                  //       iconColor: kPrimaryColor,
                  //       scale: _newsController.animation,
                  //       // calling open twitter account method
                  //       onTap: () => _newsController.openTwitterAccount(),
                  //     ),
                  //     horizontalSpace12,
                  //     IconWidget(
                  //       title: kFacebook,
                  //       iconColor: kPrimaryColor,
                  //       icon: EvilIcons.sc_facebook,
                  //       scale: _newsController.animation,
                  //       // calling open facebook account method
                  //       onTap: () => _newsController.openFacebookAccount(),
                  //     ),
                  //   ],
                  // ),
                  /*verticalSpace12,
                  Row(
                    children: [
                      IconWidget(
                        title: kFacebook,
                        iconColor: kFacebookBlue,
                        icon: EvilIcons.sc_facebook,
                        scale: _newsController.animation,
                        // calling open facebook account method
                        onTap: () => _newsController.openFacebookAccount(),
                      ),
                      horizontalSpace12,
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/*class _BoxCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? onTap;
  final Color iconColor;

  const _BoxCard({Key? key, this.onTap, required this.title, required this.icon, required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _borderRadius = BorderRadius.all(Radius.circular(12));

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          boxShadow: [BoxShadow(blurRadius: 12, spreadRadius: 2, color: kPrimaryLightColor.withOpacity(0.2))],
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: ScaleTransition(
            scale: NewsController.to.animation,
            child: MaterialCard(
              onTap: onTap,
              elevation: 0,
              margin: const EdgeInsets.only(),
              padding: const EdgeInsets.all(6),
              borderRadiusGeometry: _borderRadius,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  */ /*Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor.withOpacity(0.3)),
                    child: Center(child: Text(title.substring(0, 1).toUpperCase(), style: textStyle30Normal)),
                    // child: Center(child: Text(_title.toUpperCase(), style: textStyle30Normal)),
                  ),*/ /*
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withOpacity(0.3)),
                    child: Icon(icon, size: 50, color: iconColor),
                  ),
                  verticalSpace6,
                  Text(title, style: textStyle16Bold, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
