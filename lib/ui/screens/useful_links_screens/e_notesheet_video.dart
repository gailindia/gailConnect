
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/controllers/useful_links_controllers/e_notesheet_controller.dart';

import '../../widgets/custom_app_bar.dart';

class ENoteSheetVideoListScreen extends StatelessWidget {
  const ENoteSheetVideoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar:
      CustomAppBar(title: "Videos", isBirthdayScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GetBuilder<ENoteSheetMainController>(
              id: "kENoteSheetVideos",
              init: ENoteSheetMainController(),
              builder: (ENoteSheetMainController) {


                return Column(
                  children: [
                    // AnimatedGradient(),

                    // style: textStyle16Bold.copyWith(color: Colors.white),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ENoteSheetMainController.videoNameList.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 36),
                            itemBuilder: (context, _position) {
                              return Center(
                                // alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4), color: colorController.kPrimaryColor
                                    ),
                                    margin: const EdgeInsets.only(left: 12, right: 12),
                                    // color: Colors.blueAccent,
                                    width: MediaQuery.of(context).size.width,
                                    //height: 40,
                                    padding: const EdgeInsets.all(6),

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap:() async{

                                            /*Get.to(PdfViewer(
                                              pdfurl:
                                              "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EbpmNnHtpa5Plxp1vUBHB_8BtMcGQArD1VyMiIOPLgyJaA?e=NRTvXq",
                                              //"https://www.youtube.com/watch?v=9g7K3LuVgZ4&list=RD9g7K3LuVgZ4&start_radio=1",
                                              //"https://dev.to/logicraystech/introduction-to-flutter-animation-part-1-3520",//ENoteSheetMainController.videosList[_position].toString(),
                                              title: ENoteSheetMainController.videoNameList[_position].toString(),
                                              type: "url",
                                            ));*/
                                            await launch(ENoteSheetMainController.videosList[_position].toString());
                                            // print(ENoteSheetMainController.videosList[_position].toString());
                                            // ENoteSheetMainController.openLink(title: ENoteSheetMainController.videoNameList[_position].toString(), link: ENoteSheetMainController.videosList[_position].toString());
                                          },
                                          child: Text(ENoteSheetMainController.videoNameList[_position].toString(),
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 14,
                                              // letterSpacing: 2,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            // style: textStyle16Bold.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })

                      ],
                    ),
                  ],
                );}
          ),
        ),
      ),
    );
  }
}

/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */