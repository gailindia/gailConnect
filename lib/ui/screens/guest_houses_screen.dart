// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/guest_house.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/core/controllers/guest_house_controller.dart';

import '../styles/color_controller.dart';

class GuestHousesScreen extends StatelessWidget {
  const GuestHousesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kGuestHouses),
      body: GetBuilder<GuestHouseController>(
        id: kGuestHouses,
        init: GuestHouseController(),
        builder: (_guestHouseController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialCard(
                borderRadius: 12,
                padding: const EdgeInsets.only(),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        controller: _guestHouseController.searchController,
                        // calling on guest house search method
                        onChanged: _guestHouseController.onGuestHouseSearch,
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
                        _guestHouseController.searchController.text = '';

                        // calling on guest house search method
                        _guestHouseController.onGuestHouseSearch('');
                      },
                    ),
                  ],
                ),
              ),
              if (_guestHouseController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_guestHouseController
                  .filteredGuestHouseList.isEmpty) ...[
                const Expanded(child: NoRecordsFound()),
              ] else ...[
                verticalSpace12,
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        _guestHouseController.filteredGuestHouseList.length,
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                    itemBuilder: (context, _position) {
                      final GuestHouse _guestHouse = _guestHouseController
                          .filteredGuestHouseList[_position];
                      final String _title = _guestHouse.location!;

                      return MaterialCard(
                        borderRadius: 12,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 12, bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InitialTextContainer(text: _title),
                            horizontalSpace6,
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_title,
                                            style: textStyle18Bold.copyWith(
                                                color: colorController
                                                    .kPrimaryDarkColor)),
                                        verticalSpace6,
                                        // Text(_guestHouse.address!,
                                        //     style: textStyle12Normal.copyWith(
                                        //         color: colorController
                                        //             .kPrimaryDarkColor)),

                                        if (_guestHouse.telephone != null &&
                                            _guestHouse
                                                .telephone!.isNotEmpty) ...[
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: colorController
                                                  .kPrimaryDarkColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () async {
                                                _guestHouseController
                                                    .callNumber(
                                                        _guestHouse.telephone!);
                                                // await launch(_guestHouse.telephone!);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Feather.phone,
                                                      size: 14),
                                                  // const SizedBox(width: 3),
                                                  horizontalSpace6,
                                                  Flexible(
                                                    child: Text(
                                                      _guestHouse.telephone!,
                                                      style: textStyle12Normal
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        verticalSpace12,
                                        Text(_guestHouse.address!,
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
                                      if (_guestHouse.latitude != null &&
                                          _guestHouse.latitude! > 0) ...[
                                        InkWell(
                                          // calling open map method
                                          onTap: () => _guestHouseController
                                              .openMap(guestHouse: _guestHouse),
                                          child: Icon(
                                            MaterialCommunityIcons.google_maps,
                                            size: 28,
                                            color: colorController
                                                .kPrimaryDarkColor,
                                          ),
                                        ),
                                        verticalSpace18,
                                      ],
                                      // InkWell(
                                      //   // calling show address dialog method
                                      //   onTap: () => _guestHouseController
                                      //       .showAddressDialog(
                                      //     address: _guestHouse.address!,
                                      //     location: _guestHouse.location!,
                                      //   ),
                                      //   child: Icon(
                                      //     FontAwesome.address_card_o,
                                      //     size: 28,
                                      //     color:
                                      //         colorController.kPrimaryDarkColor,
                                      //   ),
                                      // ),
                                    ],
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
                /*Expanded(
                  child: StackedCardCarousel(
                    initialOffset: 0,
                    spaceBetweenItems: 110,
                    applyTextScaleFactor: false,
                    type: StackedCardCarouselType.fadeOutStack,
                    items: _guestHouseController.filteredGuestHouseList.map(
                      (GuestHouse _guestHouse) {
                        final String _title = _guestHouse.location!;

                        return SizedBox(
                          height: 120,
                          child: MaterialCard(
                            borderRadius: 12,
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InitialTextContainer(text: _title),
                                horizontalSpace6,
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            verticalSpace6,
                                            Flexible(
                                              child: Text(
                                                _title,
                                                style: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                                              ),
                                            ),
                                            verticalSpace18,
                                            if (_guestHouse.telephone != null && _guestHouse.telephone!.isNotEmpty) ...[
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                  color: kPrimaryLightColor,
                                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Icon(Feather.phone, size: 14),
                                                    // const SizedBox(width: 3),
                                                    horizontalSpace6,
                                                    Flexible(
                                                      child: Text(
                                                        _guestHouse.telephone!,
                                                        style: textStyle12Normal.copyWith(color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      horizontalSpace6,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          if (_guestHouse.latitude != null && _guestHouse.latitude! > 0) ...[
                                            InkWell(
                                              // calling open map method
                                              onTap: () => _guestHouseController.openMap(guestHouse: _guestHouse),
                                              child: const Icon(
                                                MaterialCommunityIcons.google_maps,
                                                size: 28,
                                                color: colorController.kPrimaryDarkColor,
                                              ),
                                            ),
                                            verticalSpace18,
                                          ],
                                          InkWell(
                                            // calling show address dialog method
                                            onTap: () => _guestHouseController.showAddressDialog(
                                              address: _guestHouse.address!,
                                              location: _guestHouse.location!,
                                            ),
                                            child: const Icon(
                                              FontAwesome.address_card_o,
                                              size: 28,
                                              color: colorController.kPrimaryDarkColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),*/
              ],
            ],
          );
        },
      ),
    );
  }
}

/*Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(_title, style: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor)),
          const Spacer(),
          InkWell(
            // calling open map method
            onTap: () => _guestHouseController.openMap(guestHouse: _guestHouse),
            child: const Icon(
              MaterialCommunityIcons.google_maps,
              size: 30,
              color: colorController.kPrimaryDarkColor,
            ),
          ),
        ],
      ),
      verticalSpace6,
      Row(
        children: [
          if (_guestHouse.telephone != null && _guestHouse.telephone!.isNotEmpty) ...[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: const BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    const Icon(Feather.phone, size: 18),
                    horizontalSpace6,
                    Expanded(
                      child: Text(
                        _guestHouse.telephone!,
                        style: textStyle13Normal.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace6,
          ] else ...[
            const Expanded(child: SizedBox()),
          ],
          InkWell(
            // calling show address dialog method
            onTap: () => _guestHouseController.showAddressDialog(
              context: context,
              address: _guestHouse.address!,
            ),
            child: const Icon(
              FontAwesome.address_card_o,
              size: 30,
              color: colorController.kPrimaryDarkColor,
            ),
          ),
        ],
      ),
    ],
  ),
),*/
