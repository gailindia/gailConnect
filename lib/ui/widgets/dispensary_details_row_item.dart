// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class DispensaryDetailsRowItem extends StatelessWidget {
  final int? maxLines;
  final String caption, desc;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry padding;
  final Icon icon;

  const DispensaryDetailsRowItem({
    Key? key,
    this.maxLines,
    this.overflow,
    required this.caption,
    required this.desc,
    required this.icon,
    this.padding = const EdgeInsets.only(top: 12, left: 12, right: 12),
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
                Text(caption, style: textStyle12Bold),
                verticalSpace6,
                Text(desc,
                    maxLines: maxLines,
                    overflow: overflow,
                    style: textStyle16Normal),
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
