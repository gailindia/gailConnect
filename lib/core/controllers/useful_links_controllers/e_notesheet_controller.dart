// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../ui/screens/pdfviewer.dart';



class ENoteSheetMainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // static const String _tag = 'NewsController';


  List videosList=
  [
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EbpmNnHtpa5Plxp1vUBHB_8BtMcGQArD1VyMiIOPLgyJaA?e=NRTvXq",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EZDGab4uCfhIofJkW1eMoN0BGFznwTp2Ss-b30rZ3ggbug?e=SXvit0",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EW_ELZlfNplDrAlyBlfpHcoBHGveRw99pfnV70LYndX-ag?e=69bmCx",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EaHeAdT03L1HsNhB7lBjKBwBa7AWByhpPHNjANgIV2Ps9Q?e=Dw5wzh",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EVf7f99pQadInssvNBs6QGcBFnMwDlyWKOb04YxqJrFHag?e=6LfUkJ",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/Eb-bVX2Z101JiUW1im5RLJ4BQLJWDJyygG_v4JypmBAOLA?e=h65P65",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EXkVcJX1JGtKuY1vDv8rybYBNcBs4nPYldt2S5xDbww4-Q?e=gE2kSx",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EZsYeMWlc1pDgRxXuiPuPmMBRfniXJZPlFwujWTcf2ZJaA?e=1Kjxdr",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EbgZGHY4IJ5DiQOZkA8LA0kBefsAbIrrohPy-jc_DXHyVQ?e=JGJteU",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EcuZGGwZbNdBtbC2gQ2pSucBWUpjgAFJuztEcRkv5gFMGA?e=6VTobe",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EURQRYgAci9KhGLNegSk9HsBBJftdmUEFNObats16rB9MQ?e=tHUlU8",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EaI3aq2HSTlOqnCyVG62LJ0BLeth07gfEe3LZqHJ1oO1Pw?e=QlGxfE",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EVQLxdCuW6BLhoAKgQtrVREB9CVDb8rW6WWrNTOSiRjxfw?e=jOi4wy",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/ES5ViH14dD5It3I1hQoz6HQBUuPLwaRO3Nm-jaqdragSCA?e=orfV7W",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EQy5jsXR4kZGmZILg2lrqJEBXLeraUdDFieReRBBF_z5lA?e=yColvK",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/ES_lj3qU4s9BpAOVaLz_0dcBMKpYmuDJt5q7tRqyw71mqw?e=DkUftJ",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/ESj3yHNVYkRJhID0jjOe9ysBQubmXhfs4jiOehKl2-VClQ?e=UXoCQW",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/ERCBeI4mS7pNnCSOCKBrdS0Bjn95PFyC63ilg5v81x2FnQ?e=XzVDO0",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EfnlEtBMEtlKkfvWVDfHw7YBxegU0w5ZZ37agh_MS0EeIw?e=to56qM",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EZniBum5nftJkadZKQZvf_wBGOsSZXIsf-7XAltfO_HkvA?e=TpxE5b",
    "https://gailcoin-my.sharepoint.com/:v:/g/personal/eofficerollout_gail_co_in/EUeJ__0hBQZJvCiZzb3mOwwB6vyxjIfhvYP0OQ-FKAj78w?e=B4PMTK",
  ];

  List videoNameList=[
    "E File All in one video",
    "How to add Green Note in e-file",
    "How to attach Receipt in e-file",
    "How to add Yellow Note in e-file",
    "How to Create a Receipt in e-file",
    "How to do Referencing in Noting",
    "How to close an e-file",
    "How to Park an e-file",
    "How to PullBack an e-file",
    "How to Pullup an e-file",
    "Advanced Search of e-file",
    "How to edit Metadata of e-file",
    "How to Print an e-file",
    "How to Reopen an e-file",
    "How to Put Receipt in e-file",
    "How to close a receipt",
    "How to Pullback a receipt",
    "How to Pullup a receipt",
    "Advanced Search of receipt",
    "How to take Print of receipt",
    "How to reopen a closed receipt",
  ];


  openLink({required String title, required String link}) async {
    // final String _link = int.parse(SharedPrefs.to.cpfNumber).toString();
    debugPrint(link);
    await launch(link);
    Get.to(PdfViewer(
      pdfurl:
      "https://gailebank.gail.co.in/GAIL_APIs/pdf/E_File_User_Manual.pdf",
      title: "User Manual",
      type: "pdf",
    ));
  }
  static ENoteSheetMainController get to =>
      Get.find<ENoteSheetMainController>();

  // late String newsCategory, newsListTitle;

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
        vsync: this, value: 0.1, duration: const Duration(milliseconds: 1000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to
    //     .hitCountApi(activity: kNewsDashboardScreen, activityScreen: "/news");
  }

  // onNewsCategorySelected(
  //     {required String hitCountScreen,
  //     required String category,
  //     required String listTitle}) {
  //   newsCategory = category;
  //   newsListTitle = listTitle;

  //   Get.toNamed(kNewsCatRoute);

  //   // calling hit count api method
  //   // GailConnectServices.to.hitCountApi(activity: hitCountScreen);
  // }

  // navigateToLiveEventsScreen() => Get.toNamed(kLiveEventRoute);

  // openTwitterAccount() {
  //   Get.toNamed(kBrowserRoute,
  //       arguments: {kUrl: kTwitterUrl, kTitle: kTwitter});

  //   // calling hit count api method
  //   GailConnectServices.to.hitCountApi(activity: kTwitterScreen);
  // }

  // openFacebookAccount() {
  //   Get.toNamed(kBrowserRoute,
  //       arguments: {kUrl: kFacebookUrl, kTitle: kFacebook});

  //   // calling hit count api method
  //   GailConnectServices.to.hitCountApi(activity: kFacebookScreen);
  // }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
