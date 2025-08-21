
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/concent_form_controller.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class ConcentFormScreen extends StatelessWidget {
  const ConcentFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '$kConcentForm', isBirthdayScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GetBuilder<ConcentFormController>(
              id: kconcentform,
              init: ConcentFormController(),
              builder: (_controller) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Do you want to display your photo in employee list?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text(
                                'YES',
                              ),
                              value: 1,
                              groupValue: _controller.selectedOption,
                              onChanged: (int? value) {
                                _controller.checkphoneoption(value);
                                // setState(() {
                                //   selectedOption = value;
                                //   // print("Selected Option: $selectedOption");
                                // });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('NO'),
                              value: 0,
                              groupValue: _controller.selectedOption,
                              onChanged: (int? value) {
                                _controller.checkphoneoption(value);
                              },
                            ),
                          ),
                        ],
                      ),


                      const Divider(),
                      const Text(
                        "Do you want to display your details in birthday list?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('YES'),
                              value: 1,
                              groupValue: _controller.bdayoption,
                              onChanged: (int? value) {
                                _controller.checkbdayoption(value);
                                // setState(() {
                                //   selectedOption = value;
                                //   // print("Selected Option: $selectedOption");
                                // });
                              },
                            ),
                          ),
                          Expanded(child: RadioListTile<int>(
                            activeColor: colorController.kPrimaryLightColor,
                            title: const Text('NO'),
                            value: 0,
                            groupValue: _controller.bdayoption,
                            onChanged: (int? value) {
                              _controller.checkbdayoption(value);
                            },
                          )),
                        ],
                      ),

                      const Divider(),
                      const Text(
                        "Do you want to display your details in superannuation list?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('YES'),
                              value: 1,
                              groupValue: _controller.superannuation,
                              onChanged: (int? value) {
                                _controller.checkannuationoption(value);
                                // setState(() {
                                //   selectedOption = value;
                                //   // print("Selected Option: $selectedOption");
                                // });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('NO'),
                              value: 0,
                              groupValue: _controller.superannuation,
                              onChanged: (int? value) {
                                _controller.checkannuationoption(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        "Do you want to display your photo in email?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('YES'),
                              value: 1,
                              groupValue: _controller.selectedOption1,
                              onChanged: (int? value) {
                                _controller.checkphoneoption1(value);
                                // setState(() {
                                //   selectedOption = value;
                                //   // print("Selected Option: $selectedOption");
                                // });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              activeColor: colorController.kPrimaryLightColor,
                              title: const Text('NO'),
                              value: 0,
                              groupValue: _controller.selectedOption1,
                              onChanged: (int? value) {
                                _controller.checkphoneoption1(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      PrimaryButton(
                        text: kSubmit,
                        onPressed: () {
                          _controller.submitConcentForm(context);
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
