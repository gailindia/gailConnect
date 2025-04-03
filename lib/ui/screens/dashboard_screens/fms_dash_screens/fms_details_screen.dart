// Created By Amit Jangid 16/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/fms_no_records_found.dart';
import 'package:gail_connect/ui/widgets/fms_details_list_widget.dart';
import 'package:gail_connect/core/controllers/dash_controllers/fms_controllers/fms_details_controller.dart';

class FmsDetailsScreen extends StatelessWidget {
  const FmsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: kFmsDashboard),
      body: GetBuilder<FmsDetailsController>(
        id: kFmsInboxDetail,
        init: FmsDetailsController(),
        builder: (_fmsDetailsController) {
          if (_fmsDetailsController.isLoading) {
            return const LoadingWidget();
          } else if (_fmsDetailsController.fmsDetailsList.isNotEmpty) {
            return FmsDetailsListWidget(fmsDetailsList: _fmsDetailsController.fmsDetailsList);
          }

          return const FmsNoRecordsFound();
        },
      ),
    );
  }
}
