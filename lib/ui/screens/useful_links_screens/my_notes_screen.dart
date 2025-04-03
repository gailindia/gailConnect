import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:gail_connect/core/controllers/my_notes_controller.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/widgets/material_card.dart';

import '../../../utils/constants/app_constants.dart';
import '../../styles/color_controller.dart';

import '../../widgets/circular_network_image_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/open_container_transition.dart';
import '../full_image_screen.dart';

class MyNotesScreen extends StatelessWidget {
  const MyNotesScreen({Key? key}) : super(key: key);

  _showInfoDialogCancel(
      BuildContext context, MyNotesController myNotesController) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          title: Column(
            children: [
              // Row(
              //   children: [
              //     // Spacer(),
              //     // GestureDetector(
              //     //     onTap: () {
              //     //       Navigator.pop(context);
              //     //     },
              //     //     child: Icon(
              //     //       Icons.cancel,
              //     //       color: Colors.black,
              //     //     ))
              //   ],
              // ),
              verticalSpace12,
              // const Divider(height: 1, color: Colors.black),
              verticalSpace6,
            ],
          ),
          content: Text("Choose from Gallery or Camera?"),
          actions: [
            TextButton(
              child: Text("Gallery"),
              onPressed: () {
                Navigator.pop(context);
                myNotesController.chooseFiles();
              },
            ),
            TextButton(
              child: Text("Camera"),
              onPressed: () {
                Navigator.pop(context);
                myNotesController.captureImage();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      appBar: CustomAppBar(title: kMyNotes),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 18),
        child: GetBuilder<MyNotesController>(
          id: kMyNotes,
          init: MyNotesController(),
          builder: (_mynotesController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 18),
              child: Column(
                children: [
                  // Obx(
                  //   () =>
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _mynotesController.notesList.length,
                      itemBuilder: (context, _position) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              // height: 100,
                              // color: Colors.amber,

                              child: MaterialCard(
                                borderRadius: 12,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        _mynotesController
                                            .notesList[_position].text
                                            .toString(),
                                        // maxLines: 10,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        // Text(
                                        //     "image data: ${_mynotesController.notesList[_position].text.toString()}"),
                                        _mynotesController
                                                .notesList[_position].attach
                                                .toString()
                                                .contains("null")
                                            ? const Icon(Icons.access_alarm)
                                            : OpenContainerTransition(
                                                tappable: (_mynotesController
                                                            .notesList[
                                                                _position]
                                                            .attach !=
                                                        null &&
                                                    _mynotesController
                                                        .notesList[_position]
                                                        .attach!
                                                        .isNotEmpty),
                                                closedShape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100))),
                                                closedBuilder: (context,
                                                        action) =>
                                                    CircularNetworkImageWidget(
                                                        imageWidth: 100,
                                                        imageHeight: 100,
                                                        imageUrl:
                                                            // "https://gailebank.gail.co.in/common_api_jai/callimages/" +
                                                            "https://gailebank.gail.co.in/GAIL_APIs/callimages/" +
                                                                _mynotesController
                                                                    .notesList[
                                                                        _position]
                                                                    .attach
                                                                    .toString()),
                                                openBuilder: (context, action) {
                                                  if (_mynotesController
                                                              .notesList[
                                                                  _position]
                                                              .attach
                                                              .toString() !=
                                                          null &&
                                                      _mynotesController
                                                          .notesList[_position]
                                                          .attach!
                                                          .toString()
                                                          .isNotEmpty) {
                                                    return FullImageScreen(
                                                        title: "Image",
                                                        imageUrl:
                                                            // "https://gailebank.gail.co.in/common_api_jai/callimages/" +
                                                            "https://gailebank.gail.co.in/GAIL_APIs/callimages/" +
                                                                _mynotesController
                                                                    .notesList[
                                                                        _position]
                                                                    .attach
                                                                    .toString()
                                                                    .toString());
                                                  } else {
                                                    return const SizedBox
                                                        .shrink();
                                                  }
                                                },
                                              ),
                                        // : GestureDetector(
                                        //     onTap: () {
                                        //       FullImageScreen(
                                        //           title: "test",
                                        //           imageUrl:
                                        // "https://gailebank.gail.co.in/common_api_jai/callimages/" +
                                        //     _mynotesController
                                        //         .notesList[
                                        //             _position]
                                        //         .attach
                                        //         .toString());
                                        //     },
                                        //     child:
                                        //         CircularNetworkImageWidget(
                                        //       imageWidth: 100,
                                        //       imageHeight: 100,
                                        //       imageUrl:
                                        //           "https://gailebank.gail.co.in/common_api_jai/callimages/" +
                                        //               _mynotesController
                                        //                   .notesList[
                                        //                       _position]
                                        //                   .attach
                                        //                   .toString(),
                                        //     ),
                                        //   ),
                                        // Image.network(
                                        // "https://gailebank.gail.co.in/common_api_jai/callimages/" +
                                        //     _mynotesController
                                        //         .notesList[_position]
                                        //         .attach
                                        //         .toString(),
                                        //     fit: BoxFit.fitWidth,
                                        //     height: 100,
                                        //     width: 100,
                                        //   ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            verticalSpace12
                          ],
                        );
                      },
                    ),
                  ),
                  // ),
                  // Spacer(),
                  // Spa/cer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialCard(
                            borderRadius: 30,
                            margin: const EdgeInsets.only(
                              left: 6,
                              bottom: 6,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 6,
                              autocorrect: false,
                              keyboardType: TextInputType.multiline,
                              controller: _mynotesController.messageController,
                              textAlignVertical: TextAlignVertical.center,
                              // textAlignVertical: TextAlignVertical.bottom,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: kEnterMessage,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                suffixIconConstraints:
                                    const BoxConstraints(maxWidth: 36),
                                prefixIconConstraints:
                                    const BoxConstraints(maxWidth: 36),
                                // prefixIcon: IconButton(
                                //   onPressed: () {},
                                //   padding: const EdgeInsets.only(),
                                //   icon: const Icon(Fontisto.smiley,
                                //       size: 20, color: kPrimaryDarkColor),
                                // ),
                                suffixIcon: IconButton(
                                  padding: const EdgeInsets.only(),
                                  // calling pick image method
                                  onPressed: () {
                                    _showInfoDialogCancel(
                                        context, _mynotesController);
                                  },
                                  // _mynotesController
                                  //  .chooseFiles(), //pickImage,
                                  icon:  Icon(Icons.photo_library_outlined,
                                      size: 20, color: colorController.kPrimaryDarkColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace6,
                        MaterialCard(
                          borderRadius: 100,
                          padding: const EdgeInsets.only(),
                          margin: const EdgeInsets.only(right: 6, bottom: 6),
                          child: Container(
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorController.kPrimaryDarkColor),
                            child: IconButton(
                              padding: const EdgeInsets.only(),
                              icon: const Icon(MaterialIcons.send,
                                      color: Colors.white)
                                  .marginOnly(left: 3),
                              // calling on message send method
                              onPressed: () => _mynotesController
                                  .onTextMessageSend(_mynotesController
                                      .messageController.value.text),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
