// Created By Amit Jangid 20/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:get/get.dart';

class TableTitle extends StatelessWidget {
  final int flex;
  final String title;
  final double height;
  final bool showRightBorder;

  const TableTitle({Key? key, this.flex = 2, this.height = 40, required this.title, this.showRightBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        decoration: showRightBorder
            ?  BoxDecoration(color:  colorController.kPrimaryLightColor, border: Border(right: BorderSide()))
            :  BoxDecoration(color: colorController.kPrimaryLightColor),
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(title, textAlign: TextAlign.center, style: textStyle12Bold.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class TableContent extends StatelessWidget {
  final int flex;
  final double height;
  final String description;
  final bool trim, showLink, showRightBorder;

  const TableContent({
    Key? key,
    this.flex = 2,
    this.height = 100,
    this.trim = false,
    this.showLink = false,
    required this.description,
    this.showRightBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showLink
        ? Expanded(
            flex: flex,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(border: Border(right: BorderSide())),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      description,
                      maxLines: trim ? 5 : null,
                      textAlign: TextAlign.center,
                      overflow: trim ? TextOverflow.ellipsis : null,
                      style: textStyle12Bold.copyWith(color: colorController.kPrimaryDarkColor, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Expanded(
            flex: flex,
            child: Container(
              alignment: Alignment.center,
              decoration: showRightBorder ? const BoxDecoration(border: Border(right: BorderSide())) : null,
              child: SizedBox(
                height: height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      description,
                      style: textStyle12Normal,
                      maxLines: trim ? 5 : null,
                      textAlign: TextAlign.center,
                      overflow: trim ? TextOverflow.ellipsis : null,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
