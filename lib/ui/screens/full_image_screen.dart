// Created By Amit Jangid 26/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/color_controller.dart';

class FullImageScreen extends StatelessWidget {
  final String title, imageUrl;

  const FullImageScreen({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    final _size = MediaQuery.of(context).size;

    // if (imageUrl.contains("isPDF")) {
    //   _openLink(title: '', link: imageUrl);
    // } //else if (imageUrl.contains("isIMAGE")) {}
    return Scaffold(
      backgroundColor: colorController.kPrimaryColor,
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: PhotoView(
          maxScale: PhotoViewComputedScale.contained * 3.0,
          minScale: PhotoViewComputedScale.contained * 0.8,
          backgroundDecoration: BoxDecoration(color: colorController.kBgColor),
          // calling get image url method
          imageProvider: CachedNetworkImageProvider(getImageUrl(imageUrl)),
          // imageProvider: imageUrl.contains("isImage") ? CachedNetworkImageProvider(getImageUrl(imageUrl)) : kIconDocument,

          loadingBuilder: (context, event) {
            if (event == null) return const SizedBox.shrink();
            // if (imageUrl.contains("isPDF")) {
            // }

            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                    width: _size.width,
                    height: _size.height,
                    color: Colors.grey[300]),
              ),
            );
          },
        ),
      ),
    );
  }

  _openLink({required String title, required String link}) async {
    // final String _link = int.parse(SharedPrefs.to.cpfNumber).toString();
    debugPrint(link);

    await launch(link);
  }
}
