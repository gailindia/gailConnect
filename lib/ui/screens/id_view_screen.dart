import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/dependent_list_controller.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape_small.dart';

import '../../config/routes.dart';
import '../widgets/circular_network_image_widget.dart';

class IDViewScreen extends StatelessWidget {
  const IDViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: "ID View"),
      body: SingleChildScrollView(
        child: GetBuilder<DependentListController>(
            init: DependentListController(),
            id: kDependentid,
            builder: (controller) {
              return controller.idviewlist.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            // height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(1)),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/icons/gail_logo.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 10),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            FittedBox(
                                              child: Text(
                                                'गेल (इंडिया) लिमिटेड',
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                                '(भारत सरकार का उपक्रम - एक महारत्न कंपनी)',
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('GAIL (India) Limited',
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                '(A Government of India Undertaking - A Maharatna Company)',
                                                textAlign: TextAlign.center,
                                                textScaleFactor: 0.8,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('पहचान पत्र / IDENTITY CARD',
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: controller.idviewlist[0]
                                                          .photo! ==
                                                      null ||
                                                  controller.idviewlist[0]
                                                      .photo!.isEmpty
                                              ? Icon(Icons.person)
                                              :
                                              // : Image.network(
                                              //     "https://gailebank.gail.co.in/WebServices/Consolidated/" +
                                              //         controller.idviewlist[0].photo!,
                                              //     width: 80,
                                              //     height: 110,
                                              //   ),
                                              CircularNetworkImageWidget(
                                                  errorImageColor: Colors.white,
                                                  imageHeight: 60,
                                                  imageWidth: 60,
                                                  imageUrl:
                                                      "https://gailebank.gail.co.in/WebServices/Consolidated/" +
                                                          controller
                                                              .idviewlist[0]
                                                              .photo!,
                                                  onTap: () {
                                                    // calling toggle animation method
//https://gailebank.gail.co.in/WebServices/Consolidated/18327photo.jpg
                                                    Get.toNamed(
                                                      kFullImageRoute,
                                                      arguments: {
                                                        kImage:
                                                            "https://gailebank.gail.co.in/WebServices/Consolidated/" +
                                                                controller
                                                                    .idviewlist[
                                                                        0]
                                                                    .photo!,
                                                        kTitle: controller
                                                            .idviewlist[0]
                                                            .empname,
                                                      },
                                                    );
                                                  },
                                                ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text("नाम",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          letterSpacing: 0,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":"),
                                                nameWidget(controller.nameHindi
                                                    .toString()),
                                                // Text(controller.name.toString(),
                                                //     style: TextStyle(
                                                //         fontSize: 12,
                                                //         fontWeight: FontWeight.w400,
                                                //         color: Colors.black)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text("Name",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        letterSpacing: 0,

                                                        // fontWeight: FontWeight.w400,
                                                        color: Colors.black)),
                                                Container(
                                                  width: 150, //double.infinity,
                                                  child: Text(
                                                      // "Billoydgd sdfgdsg ghgBilloydgd sdfgdsg ghg",
                                                      controller.nameEng
                                                          .toString(),
                                                      // softWrap: true,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: 1,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          letterSpacing: 0,

                                                          // fontWeight: FontWeight.w400,
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text(
                                                      "सीपीएफ सं॰/CPF No.",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":"),
                                                Text(
                                                    controller.cpfNo.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text("पदनाम",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":"),
                                                nameWidget(controller
                                                    .designationHindi
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text(
                                                      "Designation",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // fontWeight: FontWeight.w400,
                                                          color: Colors.black)
                                                      // style: TextStyle(
                                                      //     fontSize: 12,
                                                      //     fontWeight: FontWeight.bold),
                                                      ),
                                                ),
                                                const Text(":"),
                                                Text(
                                                    controller.designationEng
                                                        .toString(),
                                                    // textScaleFactor: 0.62,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text(
                                                      "नियुक्ति स्थान",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":"),
                                                nameWidget(controller
                                                    .locationHindi
                                                    .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 75,
                                                  child: const Text(
                                                      "Place of Posting",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                const Text(":"),
                                                Text(
                                                    controller.locationEng
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Column(
                                        //   children: [
                                        //     Row(
                                        //       children: const [
                                        //         Text("नाम",
                                        //             style: TextStyle(
                                        //                 fontSize: 12,
                                        //                 fontWeight: FontWeight.bold)),
                                        //         Spacer(),
                                        //         Text(":"),
                                        //         Text("dfghjk"),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(left: 0.0, top: 10),
                                        //   child: Column(
                                        //     // mainAxisAlignment: MainAxisAlignment.start,
                                        //     // crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [
                                        //       Row(
                                        //         mainAxisAlignment: MainAxisAlignment.start,
                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                        //         children: const [
                                        //           Text('GAIL (India) Limited'),
                                        //           Spacer(),
                                        //           Text('GAIL (India) Limited'),
                                        //         ],
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ]),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: controller
                                                    .idviewlist[0].sign!.isEmpty
                                                ? Container()
                                                : Container(
                                                    // color: Colors.amber,
                                                    child: Image.network(
                                                      "https://gailebank.gail.co.in/WebServices/Consolidated/" +
                                                          controller
                                                              .idviewlist[0]
                                                              .sign!,
                                                      width: 90,
                                                      height: 40,
                                                    ),
                                                  )),
                                        const Spacer(),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: controller.idviewlist[0]
                                                    .issuedBy!.isEmpty
                                                ? Container()
                                                : Image.network(
                                                    // "https://gailebank.gail.co.in/common_api_jai/CallImages/ID_sign/" +
                                                    "https://gailebank.gail.co.in/GAIL_APIs/CallImages/ID_sign/" +
                                                        controller.idviewlist[0]
                                                            .issuedBy!,
                                                    width: 90,
                                                    height: 40,
                                                  )
                                            // Image.asset(
                                            //   'assets/icons/sign.png',
                                            //   width: 100,
                                            //   height: 60,
                                            // ),
                                            ),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: const [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text("कर्मचारी के हस्ताक्षर",
                                                textScaleFactor: 0.9,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                        Spacer(),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Text(
                                                "जारीकर्ता प्राधिकारी के हस्ताक्षर",
                                                textScaleFactor: 0.9,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      children: const [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text("Signature of Employee",
                                                textScaleFactor: 0.9,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                        Spacer(),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
                                            child: Text(
                                                "Signature of Issuing Authority",
                                                textScaleFactor: 0.9,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            // height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(1)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20, right: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "पहचान पत्र सं. / ID Card No.",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.idcardno.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "जन्म तिथि / Date of Birth",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.dob.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "रक्त समूह / Blood Group",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.bldgroup.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "पहचान चिन्ह / Identification Mark",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Container(
                                            width: 108,
                                            child: Text(
                                                controller.identification
                                                    .toString(),
                                                textScaleFactor: 1,
                                                maxLines: 4,
                                                style: const TextStyle(
                                                    letterSpacing: 0,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "आधार सं. / Aadhar No.",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.aadharno.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "मोबाइल सं. / Mobile No.",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.mobNo.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "वैधता अवधि / Valid upto",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(controller.validupto.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 150,
                                            child: const Text(
                                                "आपातकालीन स्थिति में संपर्क करें In case of emergency, Dial",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          const Text(":"),
                                          Text(
                                              controller.emergencyDial
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 10, bottom: 20),
                                  child: Column(
                                    children: const [
                                      Text(
                                        'यदि पाया जाता है तो, कृपया निम्नलिखित पते पर लौटा दें',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'If found, please return to below mentioned address:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                          'गेल (इंडिया) लिमिटेड / GAIL (India) Limited',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                      Text('गेल भवन/ GAIL Bhawan',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          '16, भीकाएजी कामा प्‍लेस / 16 Bhikaji Cama Place',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          'नई दिल्‍ली - 110066, भारत / New Delhi - 110066 , INDIA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          'दूरभाष सं. / Telephone No: +91 11 26107352/26165430',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
            }),
      ),
    );
  }

  nameWidget(String s) {
    var unescape = HtmlUnescape();
    var name = unescape.convert(s);
    return Text(name.toString(),
        // textScaleFactor: 0.8,
        style: const TextStyle(
            fontSize: 12,
            letterSpacing: 0,

            // fontWeight: FontWeight.w400,
            color: Colors.black)
        // style: TextStyle(
        //     fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
        );
  }
}
