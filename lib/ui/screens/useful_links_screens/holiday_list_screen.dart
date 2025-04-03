/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/controllers/useful_links_controllers/useful_links_controller.dart';
import '../../widgets/custom_app_bar.dart';

class HolidyListScreen extends StatelessWidget {
  const HolidyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<UsefulLinksController>(
       id: kUsefulLinks,
        init: UsefulLinksController(),
        builder: (_usefulLinksController){
          print(kFileUrl+_usefulLinksController.holidayListPdf);
        return Scaffold(
          backgroundColor: colorController.kHomeBgColor,

          appBar: CustomAppBar(title: "Holiday List"),
          body : Container(
            child: const PDF(enableSwipe: true,
              //swipeHorizontal: true,
              autoSpacing: true,
              pageFling: false,).fromUrl(
              "https://gailebank.gail.co.in/WebServices/Holiday_List_English.pdf",
              placeholder: (double progress) => Center(child: Text('$progress %')),
              errorWidget: (dynamic error) => Center(child: Text(error.toString())),
            ),
          ),
        );
      }
    );
  }
}
