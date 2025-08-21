import 'package:flutter/material.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find<SearchController>();
  final TextEditingController searchTextController = TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  bool isSearch = false;
  Widget customSearchBar = const Text('My Searches');

  final str = [
    "Employees",
    "News",
    "Hospitals",
    "Apps",
    "Sugam",
    "Links",
    "Offices",
    "Vehicle Search",
    "BIS Helpdesk",
    "Guest House",
    "Dashboard",
    "Energy Calculator",
    "Feedback",
    "Cashless Medicine",
    "Website",
    "Intranet",
    "Tenders",
    "Mt GSTIN",
    "My Library",
    "WFH",
    "Holiday List",
    "Birthday",
    "Profile Settings"
  ];

  @override
  void onInit() {
    super.onInit();
    update([kSearchScreen]);
    searchTextController.addListener(
      () {
        if (searchTextController.text.length.toString() == "2") {
          functionality(searchTextController.text.toString());
        }
      },
    );

    // calling get current chat user method
    // getCurrentChatUser();
  }

  appbarchanges() {
    isSearch = !isSearch;
    if (isSearch == true) {
      customSearchBar = Container(
        width: double.infinity, //MediaQuery.of(context).size.width,
        child: ListTile(
          autofocus: true,
          // leading:
          //  Icon(
          //   Icons.search,
          //   color: Colors.white,
          //   size: 28,
          // ),
          title: TextField(
            // keyboardType: TextInputType.text,
            // decoration: InputDecoration(
            //   hintText: 'type in function name...',
            //   hintStyle: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //     fontStyle: FontStyle.italic,
            //   ),
            //   border: InputBorder.none,
            // ),
            autocorrect: false,
            controller: searchTextController,
            // calling on guest house search method
            // onChanged: _guestHouseController.onGuestHouseSearch,
            decoration: const InputDecoration(
              // fillColor: Color.fromARGB(255, 251, 251, 251),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 251, 251, 251), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 251, 251, 251), width: 2.0),
              ),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      update([kSearchScreen]);
    }
    if (isSearch == false) {
      customIcon = const Icon(Icons.search);
      customSearchBar = const Text('My Searches');
      update([kSearchScreen]);
    }
  }

  functionality(String x) {}
}
