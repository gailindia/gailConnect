/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */// Created By Amit Jangid 13/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String status;

  final double fontSize,letterSpacing;
  Color color;
  FontWeight fontWeight;



   TextWidget({
    Key? key,
    required this.status,
    required this.fontWeight,
    required this.color,
    required this.fontSize,
    required this.letterSpacing,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (context) {
          return Text(status,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontSize: fontSize,
                    letterSpacing: letterSpacing,
                    color: color,
                    fontWeight: fontWeight),
              ));
        }
    );
  }
}

