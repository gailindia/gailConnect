// Created By Amit Jangid 07/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/office.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:multiutillib/animations/slide_animation.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/office_controllers/offices_controller.dart';

import '../../../styles/color_controller.dart';

class OfficesScreen extends StatelessWidget {
  const OfficesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        // appBar: CustomAppBar(title: "Offices"),
        body: GetBuilder<OfficesController>(
          id: kOffices,
          init: OfficesController(),
          builder: (_officesController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.only(),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          autocorrect: false,
                          controller: _officesController.searchController,
                          // calling on offices search method
                          onChanged: _officesController.onOfficesSearch,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: kEnterLocationName,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            prefixIcon: Icon(Feather.search),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        color: colorController.kBlackShadeColor,
                        icon: const Icon(MaterialIcons.clear),
                        onPressed: () {
                          _officesController.searchController.text = '';

                          // calling on offices search method
                          _officesController.onOfficesSearch('');
                        },
                      ),
                    ],
                  ),
                ),
                if (_officesController.isLoading) ...[
                  const Expanded(child: LoadingWidget()),
                ] else if (_officesController
                    .filteredOfficesList.isNotEmpty) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: _officesController.filteredOfficesList.length,
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 36),
                      itemBuilder: (context, _position) {
                        final Office _office =
                            _officesController.filteredOfficesList[_position];

                        final int _itemCount =
                            _officesController.filteredOfficesList.length > 15
                                ? 15
                                : _officesController.filteredOfficesList.length;

                        return SlideAnimation(
                          position: _position,
                          itemCount: _itemCount,
                          animationController:
                              _officesController.animationController,
                          child: MaterialCard(
                            // color: Colors.amber,
                            borderRadius: 12,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(0),
                            // top: 8, left: 8, right: 12, bottom: 12),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 12, bottom: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //   color: Colors.black38,
                                    //   blurRadius: 3.0,
                                    //   spreadRadius: 3.0,
                                    //   offset: Offset(1.0, 1.0),
                                    // )
                                  ],
                                  color: Colors.white
                                  // gradient: const LinearGradient(
                                  //   colors: [
                                  //     colorController.kPrimaryDarkColor,
                                  //    colorController.kPrimaryColor
                                  //     // Color.fromARGB(107, 189, 207, 252),
                                  //     // Color.fromARGB(255, 224, 224, 224),
                                  //     // Color.fromARGB(255, 215, 215, 215),
                                  //     // Color.fromARGB(223, 141, 144, 139),
                                  //   ],
                                  //   begin: Alignment.bottomLeft,
                                  //   end: Alignment.topRight,
                                  // ),
                                  ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InitialTextContainer(
                                    text: _office.location??"",
                                    circleColor: colorController.kPrimaryColor,
                                  ),
                                  horizontalSpace6,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_office.location!,
                                            style: textStyle18UBold.copyWith(
                                                color: colorController
                                                    .kPrimaryDarkColor)),
                                        verticalSpace6,
                                        RichTextWidget(
                                          caption: kGailCode,
                                          captionStyle: textStyle14Bold,
                                          description: _office.gailNetCode??"",
                                          descriptionStyle: textStyle14Normal,
                                        ),
                                        if (_office.ePabX != null &&
                                            _office.ePabX!.isNotEmpty) ...[
                                          Wrap(
                                            children:
                                                _office.ePabX!.split(',').map(
                                              (String _number) {
                                                return Column(
                                                  children: [
                                                    verticalSpace6,
                                                    InkWell(
                                                      // calling call number method
                                                      onTap: () =>
                                                          _officesController
                                                              .callNumber(
                                                                  _number),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 6),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8,
                                                                horizontal: 12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorController
                                                              .kPrimaryDarkColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30)),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Icon(
                                                                Feather.phone,
                                                                size: 16),
                                                            horizontalSpace6,
                                                            Flexible(
                                                              child: Text(
                                                                _number,
                                                                style: textStyle13Normal
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        ],
                                        verticalSpace12,
                                        Text(_office.address??"",
                                            style: textStyle12Normal.copyWith(
                                                color: colorController
                                                    .kPrimaryDarkColor)),
                                      ],
                                    ),
                                  ),
                                  horizontalSpace6,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (_office.latitude!.isNotEmpty) ...[
                                        InkWell(
                                          // calling open map method
                                          onTap: () => _officesController
                                              .openMap(office: _office),
                                          child: Icon(
                                            MaterialCommunityIcons.google_maps,
                                            size: 30,
                                            color: colorController
                                                .kPrimaryDarkColor,
                                          ),
                                        ),
                                        verticalSpace24,
                                      ],
                                      // InkWell(
                                      //   // calling show address dialog method
                                      //   onTap: () => _officesController
                                      //       .showAddressDialog(
                                      //     address: _office.address!,
                                      //     location: _office.location!,
                                      //   ),
                                      //   child: Icon(FontAwesome.address_card_o,
                                      //       size: 30,
                                      //       color: colorController
                                      //           .kPrimaryDarkColor),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  const Expanded(child: NoRecordsFound()),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
