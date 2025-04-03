// Created By Amit Jangid 20/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NetworkImageWidget extends StatelessWidget {
  final BoxFit? fit;
  final String imageUrl;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback? onTap;
  final double? width, height, borderRadius;

  const NetworkImageWidget({
    Key? key,
    this.fit,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.margin = const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 6),
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      onTap: onTap,
      margin: margin,
      borderRadius: borderRadius,
      padding: const EdgeInsets.only(),
      child: imageUrl.contains('isIMAGE') || imageUrl.contains('BannerImages')
          ? CachedNetworkImage(
            colorBlendMode: BlendMode.darken,
              fit: fit,
              width: width,
              // height: height,
              imageUrl: imageUrl,
              cacheKey: getImageUrl(imageUrl),
              cacheManager: DefaultCacheManager(),
              placeholder: (context, _url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.white,
                  child: Container(
                    width: width,
                    height: Get.height * .24,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                );
              },
            )
          : Image.asset(
        imageUrl,
              height: height,
              width: 100,
            ),
    );
  }
}
