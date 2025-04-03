import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../ui/widgets/custom_dialogs/show_message_wish_dialog.dart';


class CMDOpenHouseController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? area, directorate;
  List<String> arealist = [
    'Governance',
    'Innovation',
    'New Initiative',
    'Policy',
    'R&D',
    'Strategy',
    'System Improvement',
    'Upgradation',
    'Others'
  ];
  List<String> directoratelist = [
    'BD',
    'Finance',
    'HR',
    'Marketing',
    'Projects',
  ];

  submitopenHouse(BuildContext context) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    final Map<String, String> _body = {
      "emp_id": _cpfNumber, //"17231",
      "Area": area.toString(),
      "RD": directorate.toString(),
      "Sub": subjectController.text.toString(),
      "Description": descriptionController.text.toString()
    };
    print(_body);

    final _response =
        await GailConnectServices.to.sendCMDOpenHosue(body: _body);

    if (_response != null) {
      if (_response.statusCode == 200) {
        print(_response);
        showWishDialogBox(context,
            title: "Status",
            description: _response.body['RequestId'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          Get.offNamedUntil(kMainDashRoute, (route) => false);
        });
        // Navigator.pop(context);
        subjectController.clear();
        descriptionController.clear();
        // // calling show custom dialog box method
        // // await showCustomDialogBox(context: Get.context!, title: kSuccess, description: _response.body[kJsonMessage]);

        // Get.back();
      } else {
        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kError, description: _response.body[kJsonMessage]);
      }
    }
  }

  setDataArea(String? dependant) {
    area = dependant.toString();
    update([kopenhouse]);
  }

  setDataDirectorate(String? dependant) {
    directorate = dependant.toString();
    update([kopenhouse]);
  }
}
