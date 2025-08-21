// Created By Amit Jangid 10/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/animations/slide_animation.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/control_room.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/office_controllers/control_room_controller.dart';

import '../../../styles/color_controller.dart';

class ControlRoomScreen extends StatelessWidget {
  const ControlRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<ControlRoomController>(
        id: kControlRoom,
        init: ControlRoomController(),
        builder: (_controlRoomController) {
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
                        controller: _controlRoomController.searchController,
                        // calling on control room search method
                        onChanged: _controlRoomController.onControlRoomSearch,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: kEnterLocationName,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(Feather.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    IconButton(
                      color: colorController.kBlackShadeColor,
                      icon: const Icon(MaterialIcons.clear),
                      onPressed: () {
                        _controlRoomController.searchController.text = '';

                        // calling on control room search method
                        _controlRoomController.onControlRoomSearch('');
                      },
                    ),
                  ],
                ),
              ),
              if (_controlRoomController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_controlRoomController.filteredControlRoomList.isNotEmpty) ...[
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                    itemCount: _controlRoomController.filteredControlRoomList.length,
                    itemBuilder: (context, _position) {
                      final ControlRoom _controlRoom = _controlRoomController.filteredControlRoomList[_position];

                      final int _itemCount = _controlRoomController.filteredControlRoomList.length > 15
                          ? 15
                          : _controlRoomController.filteredControlRoomList.length;

                      return SlideAnimation(
                        position: _position,
                        itemCount: _itemCount,
                        animationController: _controlRoomController.animationController,
                        child: MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InitialTextContainer(text: _controlRoom.location!),
                              horizontalSpace6,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _controlRoom.location!,
                                      style: textStyle18Bold.copyWith(color: colorController.kPrimaryDarkColor),
                                    ),
                                    verticalSpace6,
                                    RichTextWidget(
                                      caption: kControlRoom,
                                      captionStyle: textStyle14Bold,
                                      descriptionStyle: textStyle14Normal,
                                      description: _controlRoom.subLocation!,
                                    ),
                                    if (_controlRoom.hbjNo!.isNotEmpty) ...[
                                      Text(_controlRoom.hbjNo!, style: textStyle14Normal),
                                    ],
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}
