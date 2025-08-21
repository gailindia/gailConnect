// Created By Amit Jangid 14/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/enter_vehicle_no.dart';
import 'package:get/get.dart';

import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/emp_list_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/vehicle_search_controller.dart';

import '../../../rest/gail_connect_services.dart';
import '../../styles/color_controller.dart';

class VehicleSearchScreen extends StatelessWidget {
  const VehicleSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kVehicleSearch),
      body: GetBuilder<VehicleSearchController>(
        id: kVehicleSearch,
        init: VehicleSearchController(),
        builder: (_vsController) {
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
                        controller: _vsController.searchController,
                        // calling on vehicle search method
                        onChanged: _vsController.onVehicleSearch,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: kEnterVehicleNo,
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
                        _vsController.searchController.text = '';

                        // calling on vehicle search method
                        _vsController.onVehicleSearch('');
                      },
                    ),
                  ],
                ),
              ),
              if (_vsController.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_vsController.filteredEmpList.isNotEmpty) ...[
                // Expanded(child: NoRecordsFound()),
                _vsController.search == false ||
                        _vsController.searchController.text == ''
                    // ignore: prefer_const_constructors
                    ? Expanded(child: EnterVehicleNumber())
                    : Expanded(
                        child: EmpListWidget(
                          showVehicleNo: true,
                          employeeList: _vsController.filteredEmpList,
                          superannuationmodel: [],
                          phoneConsent: _vsController.phoneConsentList,
                          animationController:
                              _vsController.animationController,
                        ),
                      ),
              ] else ...[
                const Expanded(child: EnterVehicleNumber()),
              ],
            ],
          );
        },
      ),
    );
  }
}
