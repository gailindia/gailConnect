// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

import '../../core/controllers/useful_links_controllers/dispensary_add_call_controller.dart';

class HeadingRowItem extends StatelessWidget {
  final int? maxLines;
  final String caption, desc, icon;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry padding;

  const HeadingRowItem({
    Key? key,
    this.maxLines,
    this.overflow,
    required this.icon,
    required this.caption,
    required this.desc,
    this.padding = const EdgeInsets.only(top: 12, left: 12, right: 12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DispensaryHistoryController _controller =
        Get.put(DispensaryHistoryController());
    var str = icon.split(",");
    // String str1 = str[0].toString();
    // String str2 = str[1].toString();
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                caption,
                style: textStyle12Bold,
              )),
          Text(':', style: textStyle14Bold),
          horizontalSpace6,
          Expanded(
              flex: 4,
              child: Text(desc,
                  maxLines: maxLines,
                  textScaleFactor: 1,
                  overflow: overflow,
                  style: textStyle14Normal)),
          horizontalSpace6,
          icon == "prescription"
              ? Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.medication_outlined,
                    color: Colors.black,
                  ))
              : (icon == "mobile"
                  ? Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () {
                            _controller.getCallApollo();
                          },
                          child: Icon(
                            Icons.phone_enabled,
                            color: Colors.black,
                          )))
                  : Text("")),
        ],
      ),
    );
  }
}
