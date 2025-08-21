// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/ui/widgets/fms_details_list_widget.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_search_controller.dart';

import '../../../styles/color_controller.dart';

class FmsSearchScreen extends StatelessWidget {
  const FmsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        body: GetBuilder<FmsSearchController>(
          id: kFmsSearch,
          init: FmsSearchController(),
          builder: (_fmsSearchController) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MaterialCard(
                      borderRadius: 12,
                      padding: const EdgeInsets.only(),
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, right: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              autocorrect: false,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _fmsSearchController.searchController,
                              decoration: const InputDecoration(
                                hintText: kEnterFileId,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          if (_fmsSearchController
                              .searchController.value.text.isNotEmpty) ...[
                            IconButton(
                              color: colorController.kBlackShadeColor,
                              icon: const Icon(MaterialIcons.clear),
                              // calling clear search text method
                              onPressed: () =>
                                  _fmsSearchController.clearSearchText(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  MaterialCard(
                    borderRadius: 12,
                    margin: const EdgeInsets.only(top: 12, right: 12),
                    // calling get fms detail list method
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      _fmsSearchController.getFmsDetailList();
                    },
                    child: Icon(Feather.search,
                        color: colorController.kPrimaryDarkColor),
                  ),
                ],
              ),
              if (_fmsSearchController.isLoading) ...[
                const Expanded(
                    child: SingleChildScrollView(child: LoadingWidget())),
              ] else if (_fmsSearchController.fmsDetailsList.isEmpty) ...[
                verticalSpace30,
                const Expanded(child: FmsNoRecordsFound()),
                verticalSpace30,
              ] else ...[
                Expanded(
                    child: FmsDetailsListWidget(
                        fmsDetailsList: _fmsSearchController.fmsDetailsList)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
