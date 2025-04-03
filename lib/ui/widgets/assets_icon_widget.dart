// Created By Amit Jangid on 16/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';

import '../styles/color_controller.dart';

class AssetsIconWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final Color iconColor;
  final bool showIconColor;
  final Animation<double> scale;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry padding;


   AssetsIconWidget(

       {
    Key? key,
    this.onTap,
    this.showIconColor = true,
    this.iconColor = Colors.black,
    this.padding = const EdgeInsets.all(12),
    required this.scale,
    required this.title,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    const _borderRadius = BorderRadius.all(Radius.circular(12));

    return Expanded(
      child: Container(
        padding:  EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          boxShadow: [BoxShadow(blurRadius: 12, spreadRadius: 2, color: colorController.kPrimaryLightColor.withOpacity(0.2))],
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: ScaleTransition(
            scale: scale,
            child: MaterialCard(
              onTap: onTap,
              elevation: 0,
              margin: const EdgeInsets.only(),
              padding: const EdgeInsets.all(6),
              borderRadiusGeometry: _borderRadius,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: padding,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withOpacity(0.3)),
                    child: Image(height: 40, color: showIconColor ? iconColor : null, image: AssetImage(iconName)),
                  ),
                  verticalSpace6,
                  FittedBox(child: Container(
                    width: 200,
                    child: Text(

                        title, style: textStyle16Bold, textAlign: TextAlign.center,

                    maxLines: 2,),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
