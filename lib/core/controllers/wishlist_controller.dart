

import 'package:gail_connect/models/emp_wishes.dart';
import 'package:get/get.dart';

import '../../../../rest/gail_connect_services.dart';
import '../../../../utils/constants/app_constants.dart';

class WishListController extends GetxController
{

  static WishListController get to => Get.find<WishListController>();

  bool isLoading = true;

  List<EmpWishesModel> wisheslist = [];

  @override
  void onInit() {
    super.onInit();

    // calling get emp groups list method
    getEmpWishesList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kEmployeesGroupsScreen);
  }

  getEmpWishesList() async {
    isLoading = true;
    update([kwishesid]);

    // calling get emp groups list api method
    wisheslist = await GailConnectServices.to.getwishesList();
    print(wisheslist);
    print("gfhvjbknl;");

    isLoading = false;
    update([kwishesid]);
  }

  // String getDuration(String t1,String t2){
  //   final format = DateFormat("HH:mm");
  //   final one = format.parse(t1.substring(0,4));
  //   final two = format.parse(t2.substring(0,4));
  //
  //   final String duration = one.difference(two).toString().substring(0,4);
  //
  //   return duration;
  //
  // }

  // String getTimeFormat(String s){
  //
  //   final format = DateFormat("HH:mm");
  //   final String newString = format.parse(s).toString();
  //
  //   return newString;
  // }
  //
  // String getDateFormat(String date){
  //
  //   var inputFormat = DateFormat('yyyy-MM-dd');
  //   var inputDate = inputFormat.parse(date);
  //   var outputFormat = DateFormat('dd-MM-yyyy');
  //   return outputFormat.format(inputDate);
  //
  // }
  //
  // String getBirthdayFormat(String date){
  //
  //   var inputFormat = DateFormat('yyyy-MM-dd');
  //   var inputDate = inputFormat.parse(date);
  //   var outputFormat = DateFormat('dd-MMM');
  //   return outputFormat.format(inputDate);
  //
  // }

}