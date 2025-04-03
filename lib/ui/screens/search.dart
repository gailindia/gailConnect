import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';

import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

typedef OnSearchChanged = Future<List<String>> Function(String);

class SearchWithSuggestionDelegate extends SearchDelegate<String> {
  ///[onSearchChanged] gets the [query] as an argument. Then this callback
  ///should process [query] then return an [List<String>] as suggestions.
  ///Since its returns a [Future] you get suggestions from server too.
  final OnSearchChanged onSearchChanged;
  // List? mostUsed = MainDashController().mostUsedList;

  ///This [_oldFilters] used to store the previous suggestions. While waiting
  ///for [onSearchChanged] to completed, [_oldFilters] are displayed.
  List<String> _oldFilters = const [];

  List<String> data = [
    "Employees",
    "News Dashboard",
    "Cashless Medicine",
    "Feedback",
    "Useful Links",
    "Useful Documents",
    "My GSTIN",
    "Vehicle Search",
    "BIS Helpdesk",
    "Offices",
    "Employees Birthday",
    "Energy Calculator",
    "Sugam",
    "Website",
    "Intranet",
    "Tenders",
    "My Library",
    "Holiday List",
    "Guest House",
    "Hospitals",
    "Profile Settings",
    "Health",
    "Super Annuation",
    "Profile",
    "ID View",
    "Wishes",
    "Consent Form",
    "Open House",
    "Gail Voice",
    "App Store",
    "New Employee Zone",
    "MM T Codes",
    "Hindi Shabdavali",
    "Gail Prashashanik ShabadKosh",
    "Dashboard"
  ];

  SearchWithSuggestionDelegate(
      {String? searchFieldLabel,
      required this.onSearchChanged,
      List? mostUsedList})
      : super(searchFieldLabel: searchFieldLabel);

  ///
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  ///OnSubmit in the keyboard, returns the [query]
  @override
  void showResults(BuildContext context) {
    close(context, query);
  }

  ///Since [showResults] is overridden we can don't have to build the results.
  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    var listToShow = data;
    List? mostUsed;
    if (query.isNotEmpty) {
      listToShow = data
          .where((e) => e.isCaseInsensitiveContainsAny(query
                  .toString()) //contains(query.capitalizeFirst.toString()),
              )
          .toList();
    }
    final bool isSearchOn = listToShow.length >= 15 ? false : true;
    if (isSearchOn == true) {
      return Container(
        color: colorController.kPrimaryColor,
        child: ListView.builder(
          itemCount: listToShow.length,
          itemBuilder: (_, i) {
            var noun = listToShow[i];
            bool isSearch = listToShow.length >= 20 ? false : true;

            return ListTile(
              title: Text(noun),
              onTap: () => close(context, noun),
            );
          },
        ),
      );
    } else {
      return Container(
        color: colorController.kPrimaryColor,
        child: GetBuilder<MainDashController>(
          id: 'Search',
          init: MainDashController(),
          builder: (_mainDashController) {
            print("HOLA" +
                _mainDashController.mostUsedListRevised!.length.toString());

            // if (snapshot.hasData) _oldFilters = snapshot.data!;
            // print("LIST SIZE: " +
            //     _mainDashController.mostUsedList!.length.toString());

            return _mainDashController.mostUsedListRevised!.length >= 5
                ? Container(
                    color: colorController.kPrimaryColor,
                    child: ListView.builder(
                      // controller: MainDashController(),
                      itemCount:
                          _mainDashController.mostUsedListRevised!.length >= 5
                              ? 5
                              : _mainDashController.mostUsedListRevised!.length,
                      // itemCount: _mainDashController.mostUsedList!.length >= 5
                      //     ? 5
                      //     : _mainDashController.mostUsedList!.length,
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 36),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.restore),
                          title: Text(_mainDashController
                              .mostUsedListRevised![index].activity
                              .toString()),
                          // onTap: () => _mainDashController.openScreen(
                          //     _mainDashController.mostUsedListRevised![index].activity
                          //         .toString(),
                          //     _mainDashController.mostUsedListRevised![index].screen
                          //         .toString()), //close(context, _oldFilters[index]),
                          onTap: () => _mainDashController.openActivity(
                              context,
                              _mainDashController
                                  .mostUsedListRevised![index].screen
                                  .toString()),
                        );
                      },
                    ),
                  )
                : Container(
                    color: colorController.kPrimaryColor,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, i) {
                        var noun = listToShow[i];
                        bool isSearch = listToShow.length >= 20 ? false : true;

                        return ListTile(
                          title: Text(noun),
                          onTap: () => close(context, noun),
                        );
                      },
                    ),
                  );
          },
        ),
      );
    }
  }
}
