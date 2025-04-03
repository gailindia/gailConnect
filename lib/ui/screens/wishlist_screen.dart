import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/wishlist_controller.dart';
import 'package:gail_connect/ui/screens/full_image_screen.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/ui/widgets/open_container_transition.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../../utils/constants/app_constants.dart';
import '../styles/color_controller.dart';
import '../widgets/custom_app_bar.dart';

class EmpWishesScreen extends StatelessWidget {
  const EmpWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: 'My Wishes', isBirthdayScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GetBuilder<WishListController>(
              id: kwishesid,
              init: WishListController(),
              builder: (_wishListController) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(" Wishes Count : ${_wishListController.wisheslist.length}"),
                        )),
                    ListView.builder(
                        itemCount: _wishListController.wisheslist.length,
                        shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 36),
                        itemBuilder: (context, _position) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(0.7)
                                    ),
                                margin:
                                    const EdgeInsets.only(left: 12, right: 12),
                                // color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width,
                                //height: 40,
                                padding: const EdgeInsets.all(0),

                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OpenContainerTransition(
                                            tappable: (_wishListController
                                                        .wisheslist[_position]
                                                        .photo !=
                                                    null &&
                                                _wishListController
                                                    .wisheslist[_position]
                                                    .photo
                                                    .isNotEmpty),
                                            closedShape:
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                35))),
                                            closedBuilder: (context, action) =>
                                                CircularNetworkImageWidget(
                                              imageWidth: 60,
                                              imageHeight: 60,
                                              imageUrl: _wishListController
                                                  .wisheslist[_position].photo,
                                            ),
                                            openBuilder: (context, action) {
                                              if (_wishListController
                                                          .wisheslist[_position]
                                                          .photo !=
                                                      null &&
                                                  _wishListController
                                                      .wisheslist[_position]
                                                      .photo
                                                      .isNotEmpty) {
                                                return FullImageScreen(
                                                    title: _wishListController
                                                        .wisheslist[_position]
                                                        .photo,
                                                    imageUrl:
                                                        _wishListController
                                                            .wisheslist[
                                                                _position]
                                                            .photo);
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
                                        ),

                                        horizontalSpace12,

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              verticalSpace12,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.5,
                                                              child: Text(
                                                                  "${_wishListController.wisheslist[_position].SENDER_NAME}     ",
                                                                  maxLines: 2,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          textStyle:
                                                                              textStyle12Bold)),
                                                            ),
                                                          ],
                                                        ),
                                                        verticalSpace3,
                                                        Text(
                                                            "${_wishListController.wisheslist[_position].SENDER_DESIGNATION}     ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    textStyle:
                                                                        textStyle9Bold)),
                                                        verticalSpace3,
                                                        Text(
                                                            "${_wishListController.wisheslist[_position].SENDER_PLACE_OF_POSTING}     ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    textStyle:
                                                                        textStyle9Normal)),
                                                        verticalSpace3,
                                                        Text(
                                                            "SENT ON : ${DateFormat("dd/MMM/yyyy").format(DateFormat("yyyy-MM-ddTHH:mm:ss").parse(_wishListController.wisheslist[_position].sentOn))}     ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                textStyle:
                                                                textStyle9Normal.copyWith(fontSize: 8))),
                                                        verticalSpace3,
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 0,
                                          bottom: 10),
                                      child: Container(
                                        // height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1, color: Colors.grey),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0,
                                              top: 8,
                                              bottom: 8,
                                              right: 5),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              _wishListController
                                                  .wisheslist[_position]
                                                  .message,
                                              // overflow: TextOverflow.ellipsis,
                                              // maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                );
              }),
        ),
      ),
    );
  }
}
