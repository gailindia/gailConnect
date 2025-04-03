// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/screens/full_image_screen.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/ui/widgets/open_container_transition.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class FresherZoneListWidget extends StatelessWidget {
  final int? maxLines, id;
  final String title, content;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry padding;
  final String? image;

  const FresherZoneListWidget({
    Key? key,
    this.maxLines,
    this.id,
    this.overflow,
    required this.title,
    required this.content,
    this.image,
    this.padding =
        const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   flex: 2,
          //   child: icon,
          // ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textStyle16Bold),
                const Divider(),
                verticalSpace12,
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                          "Virat Kohli is an Indian international cricketer and former captain of the Indian national team. He is widely regarded as one of the greatest batsmen of all time in international cricket. Kohli plays as a right-handed batsman for Royal Challengers Bangalore in the IPL and for Delhi in Indian domestic cricket.",
                          maxLines: maxLines,
                          overflow: overflow,
                          style: textStyle14Normal),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: OpenContainerTransition(
                          tappable: (image != null && image!.isNotEmpty),
                          closedShape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          closedBuilder: (context, action) =>
                              CircularNetworkImageWidget(
                                  // imageWidth: imageWidth,
                                  // imageHeight: imageHeight,
                                  imageUrl: image.toString()),
                          openBuilder: (context, action) {
                            if (image != null && image!.isNotEmpty) {
                              return FullImageScreen(
                                  title: title, imageUrl: image.toString());
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),

                        // Image.network(
                        //     'https://c.ndtvimg.com/2020-08/hgfc9108_kohli-twitter_625x300_18_August_20.jpg?output-quality=80&downsize=1278:*'),
                      ),
                    )
                  ],
                ),
                verticalSpace6,
              ],
            ),
          ),

          // const Text(':', style: textStyle16Bold),
          // horizontalSpace6,
          // Expanded(
          //     flex: 5,
          //     child: ),
        ],
      ),
    );
  }
}
