import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../ui/widgets/custom_dialogs/show_message_wish_dialog.dart';

class ConcentFormController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? selectedOption, selectedOption1, photoval, bdayoption, superannuation;
  List<int> lstconsent = [];
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    lstconsent = await GailConnectServices.to.getConsentSavedApi(_cpfNumber);

    selectedOption = lstconsent[0];
    selectedOption1 = lstconsent[1];
    bdayoption = lstconsent[2];
    superannuation = lstconsent[3];
    // getConsentData();
    update([kconcentform]);
  }

  void checkphoneoption(int? value) {
    selectedOption = value;

    update([kconcentform]);
  }

  void checkphoneoption1(int? value) {
    selectedOption1 = value;
    update([kconcentform]);
  }

  void checkbdayoption(int? value) {
    bdayoption = value;
    update([kconcentform]);
  }

  void checkannuationoption(int? value) {
    superannuation = value;
    update([kconcentform]);
  }

  submitConcentForm(BuildContext context) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    final Map<String, dynamic> _body = {
      //"17231",
      "cpf_no": _cpfNumber,
      "PHONE_CONSENT": selectedOption ,
      "EMAIL_CONSENT": selectedOption1 ,
      "DOB_CONSENT": bdayoption ,
      "Superannuation_CONSENT": superannuation
    };

    final _response =
        await GailConnectServices.to.sendConcentFormData(body: _body);

    if (_response != null) {
      if (_response.statusCode == 200) {
        // await pref.putInt("isPhoneConsent", _response.body['PHONE_CONSENT'],isEncrypted: true);
        // await pref.putInt("isEmailConsent", _response.body['EMAIl_CONSENT'],isEncrypted: true);
        // await pref.putInt("isDobConsent", _response.body['DOB_CONSENT'],isEncrypted: true);
        // await pref.putInt("isSuperannuationConsent", _response.body['Superannuation_CONSENT'],isEncrypted: true);

        showWishDialogBox(context,
            title: "Status",
            description: _response.body['message'].toString(),
            onNegativePressed: () {}, onPositivePressed: () {
          Navigator.pop(context);
          Get.offNamedUntil(kMainDashRoute, (route) => false);
        });

        // Get.back();
      } else {
        // calling show custom dialog box method
        // await showCustomDialogBox(context: Get.context!, title: kError, description: _response.body[kJsonMessage]);
      }
    }
  }
}
