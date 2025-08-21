// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';

import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class NotificationCardWidget extends StatelessWidget {
  final int? maxLines, id;
  final String title, content;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry padding;
  final String? image;

  const NotificationCardWidget({
    Key? key,
    this.maxLines,
    this.id,
    this.overflow,
    required this.title,
    required this.content,
    this.image,
    this.padding = const EdgeInsets.
        // all(0)
        only(top: 12, left: 12, right: 12, bottom: 6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    ColorController colorController = Get.put(ColorController());
    return SingleChildScrollView(
      child: Container(
        // color: Color.fromARGB(73, 0, 34, 255),
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              verticalSpace12,
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  image.toString(),
                  fit: BoxFit.contain,
                ),
              ),
              verticalSpace18,
              Text(
                title,
                style:  TextStyle(
                  fontSize: 30,
                  color: colorController.kBlackColor,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.none,
                ),
              ),
              verticalSpace3,
              Divider(
                thickness: 1,
                indent: _width * 0.3,
                endIndent: _width * 0.3,
              ),
              verticalSpace12,
              Text(content, style: textStyle16Bold),
              verticalSpace12,
              Divider(thickness: 1.5, color: Color.fromARGB(37, 0, 0, 0)),
            ],
          ),
          // child: Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // Expanded(
          //     //   flex: 2,
          //     //   child: icon,
          //     // ),
          //     Expanded(
          //       flex: 7,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           PhotoView(
          //             maxScale: PhotoViewComputedScale.contained * 3.0,
          //             minScale: PhotoViewComputedScale.contained * 0.8,
          //             backgroundDecoration: const BoxDecoration(color: kBgColor),
          //             // calling get image url method
          //             imageProvider: CachedNetworkImageProvider(
          //               getImageUrl(image),
          //             ),
          //           ),
          //           Text(title, style: textStyle16Bold),
          //           const Divider(),
          //           verticalSpace12,
          //           Row(
          //             children: [
          //               Expanded(
          //                 flex: 5,
          //                 child: Text(content,
          //                     // "Virat Kohli is an Indian international cricketer and former captain of the Indian national team. He is widely regarded as one of the greatest batsmen of all time in international cricket. Kohli plays as a right-handed batsman for Royal Challengers Bangalore in the IPL and for Delhi in Indian domestic cricket.",
          //                     maxLines: maxLines,
          //                     overflow: overflow,
          //                     style: textStyle14Normal),
          //               ),
          //               Expanded(
          //                 flex: 2,
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 8.0),
          //                   child: OpenContainerTransition(
          //                     tappable: (image != null && image!.isNotEmpty),
          //                     closedShape: const RoundedRectangleBorder(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(100))),
          //                     closedBuilder: (context, action) =>
          //                         CircularNetworkImageWidget(
          //                             // imageWidth: imageWidth,
          //                             // imageHeight: imageHeight,
          //                             imageUrl: image.toString()),
          //                     openBuilder: (context, action) {
          //                       if (image != null && image!.isNotEmpty) {
          //                         return FullImageScreen(
          //                           title: title,
          //                           imageUrl: image.toString(),
          //                         );
          //                       } else {
          //                         return const SizedBox.shrink();
          //                       }
          //                     },
          //                   ),

          //                   // Image.network(
          //                   //     'https://c.ndtvimg.com/2020-08/hgfc9108_kohli-twitter_625x300_18_August_20.jpg?output-quality=80&downsize=1278:*'),
          //                 ),
          //               )
          //             ],
          //           ),
          //           verticalSpace6,
          //         ],
          //       ),
          //     ),

          //     // const Text(':', style: textStyle16Bold),
          //     // horizontalSpace6,
          //     // Expanded(
          //     //     flex: 5,
          //     //     child: ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
