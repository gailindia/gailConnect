
import 'package:gail_connect/models/id_view_model.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:html_character_entities/html_character_entities.dart';

class DependentListController extends GetxController {
  List<IDViewModel> idviewlist = [];
  var name;
  bool isLoading = true;
  String? aadharno = "",
      idcardno = "",
      nameHindi = "",
      nameEng = "",
      cpfNo = "",
      designationHindi = "",
      designationEng = "",
      locationHindi = "",
      locationEng = "",
      dob = "",
      bldgroup = "",
      identification = "",
      mobNo = "",
      validupto = "",
      emergencyDial = "";
  // HtmlEscape htmlEscape = HtmlEscape();

  @override
  void onInit() {
    super.onInit();
    // calling get guest house details method
    getAppStoreUrl();
  }

  void getAppStoreUrl() async {
    isLoading = true;
    // update([kGuestHouses]);

    // calling get guest houses list from db method
    idviewlist = await GailConnectServices.to.getAllIdViewData();
    aadharno =
        idviewlist[0].aadhar == null ? "" : idviewlist[0].aadhar.toString();
    idcardno =
        idviewlist[0].idcardno == null ? "" : idviewlist[0].idcardno.toString();
    nameHindi = idviewlist[0].emp_name_hindi == null
        ? ""
        : idviewlist[0].emp_name_hindi.toString();
    nameEng =
        idviewlist[0].empname == null ? "" : idviewlist[0].empname.toString();
    cpfNo = idviewlist[0].empno == null ? "" : idviewlist[0].empno.toString();
    designationHindi = idviewlist[0].designation_hindi == null
        ? ""
        : idviewlist[0].designation_hindi.toString();
    designationEng = idviewlist[0].designation == null
        ? ""
        : idviewlist[0].designation.toString();
    locationHindi = idviewlist[0].location_hindi == null
        ? ""
        : idviewlist[0].location_hindi.toString();
    locationEng =
        idviewlist[0].location == null ? "" : idviewlist[0].location.toString();
    dob = idviewlist[0].dob == null ? "" : idviewlist[0].dob.toString();
    bldgroup =
        idviewlist[0].bloodgrp == null ? "" : idviewlist[0].bloodgrp.toString();
    identification =
        idviewlist[0].idmark == null ? "" : idviewlist[0].idmark.toString();
    validupto = idviewlist[0].validupto == null
        ? ""
        : idviewlist[0].validupto.toString();
    emergencyDial = idviewlist[0].phemergency == null
        ? ""
        : idviewlist[0].phemergency.toString();

    print("dependantList  " + idviewlist.toString());
    // HtmlCharacterEntities.encode('prince sharma');

    // name = htmlEscape.convert("'prince sharma'");
    String string = 'An ampersand can be written as &amp; and &#38;.';

    print(HtmlCharacterEntities.decode(
        string)); // An ampersand can be written as & and &.
    print("fghjk");

    isLoading = false;
    update([kDependentid]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
