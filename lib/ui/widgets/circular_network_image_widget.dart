// Created By Amit Jangid 26/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../styles/color_controller.dart';

class CircularNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool showGroupImage;
  final Color errorImageColor;
  final GestureTapCallback? onTap;
  final double? imageWidth, imageHeight;

  const CircularNetworkImageWidget({
    Key? key,
    this.onTap,
    this.imageWidth = 60,
    this.imageHeight = 60,
    this.showGroupImage = false,
    this.errorImageColor = Colors.black,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    if (imageUrl.isNotEmpty) {
      /*return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: InkWell(
          onTap: onTap,
          child: Image(
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.scaleDown,
            image: NetworkImage(getImageUrl(imageUrl)),
            errorBuilder: (context, e, s) {
              return Icon(
                showGroupImage ? Icons.supervised_user_circle_sharp : EvilIcons.user,
                size: imageWidth,
                color: showGroupImage ? kDarkGreyColor : kPrimaryDarkColor,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
                ),
              );
            },
          ),
        ),
      );*/

      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: CachedNetworkImage(
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.scaleDown,
          imageUrl: getImageUrl(imageUrl),
          cacheKey: getImageUrl(imageUrl),
          cacheManager: DefaultCacheManager(),
          errorWidget: (context, url, error) => Icon(
            showGroupImage
                ? Icons.supervised_user_circle_sharp
                : EvilIcons.user,
            size: imageWidth,
            color: showGroupImage
                ? colorController.kDarkGreyColor
                : errorImageColor,
          ),
          imageBuilder: (context, imageProvider) => Material(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: InkWell(
                onTap: onTap,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image(
                    width: imageWidth,
                    height: imageHeight,
                    image: imageProvider,
                    fit: BoxFit.scaleDown),
                // child: CircleAvatar(radius: 25, backgroundImage: imageProvider),
              ),
            ),
          ),
          placeholder: (context, _url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                    color: Colors.grey[300], shape: BoxShape.circle),
              ),
            );
          },
        ),
      );
    } else {
      return Icon(
        showGroupImage ? Icons.supervised_user_circle_sharp : EvilIcons.user,
        size: imageWidth,
        color:
            showGroupImage ? colorController.kDarkGreyColor : errorImageColor,
      );
    }
  }
}
