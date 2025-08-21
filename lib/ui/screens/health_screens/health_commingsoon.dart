import 'package:flutter/material.dart';

import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class HealthCoominSoonScreen extends StatelessWidget {
  const HealthCoominSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return Scaffold(
              backgroundColor: colorController.kHomeBgColor,
              appBar: CustomAppBar(title: 'Health ', isBirthdayScreen: false),
              body: const Center(
                child:Text("Coming soon...",style: TextStyle(fontSize: 20),)
              )
          );
        }
    );



  }
}

