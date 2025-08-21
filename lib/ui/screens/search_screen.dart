// // import 'dart:io';

// // import 'package:dropdown_search/dropdown_search.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gail_connect/core/controllers/search_controller.dart';
// // import 'package:gail_connect/utils/constants/app_constants.dart';
// // import 'package:get/get_state_manager/get_state_manager.dart';
// // import 'package:multiutillib/widgets/custom_app_bar.dart';

// // import '../styles/text_styles.dart';
// // import '../widgets/no_records_found.dart';

// // class SearchScreen extends StatelessWidget {
// //   const SearchScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final List<String> _suggestions = [
// //       'United States',
// //       'Germany',
// //       'Washington',
// //       'Paris',
// //       'Jakarta',
// //       'Australia',
// //       'India',
// //       'Czech Republic',
// //       'Lorem Ipsum',
// //     ];
// //     final List<String> _statesOfIndia = [
// //       'Andhra Pradesh',
// //       'Assam',
// //       'Arunachal Pradesh',
// //       'Bihar',
// //       'Goa',
// //       'Gujarat',
// //       'Jammu and Kashmir',
// //       'Jharkhand',
// //       'West Bengal',
// //       'Karnataka',
// //       'Kerala',
// //       'Madhya Pradesh',
// //       'Maharashtra',
// //       'Manipur',
// //       'Meghalaya',
// //       'Mizoram',
// //       'Nagaland',
// //       'Orissa',
// //       'Punjab',
// //       'Rajasthan',
// //       'Sikkim',
// //       'Tamil Nadu',
// //       'Tripura',
// //       'Uttaranchal',
// //       'Uttar Pradesh',
// //       'Haryana',
// //       'Himachal Pradesh',
// //       'Chhattisgarh'
// //     ];
// //     final _formKey = GlobalKey<FormState>();
// //     VoidCallback? onBackButtonPressed;
// //     final bool isHomeScreen = false;
// //     return GetBuilder<SearchController>(
// //         id: kSearchScreen,
// //         init: SearchController(),
// //         builder: (_controller) {
// //           return Scaffold(
// //             appBar: //CustomAppBar(title: "Search"),
// //                 AppBar(
// //               title: _controller.customSearchBar,
// //               automaticallyImplyLeading: false,
// //               actions: [
// //                 IconButton(
// //                     onPressed: () {
// //                       _controller.appbarchanges();
// //                     },
// //                     icon: _controller.isSearch == false
// //                         ? const Icon(Icons.search)
// //                         : const Icon(Icons.cancel))
// //               ],
// //               centerTitle: true,
// //               leading: IconButton(
// //                 onPressed: onBackButtonPressed ??
// //                     () => isHomeScreen ? exit(0) : Navigator.pop(context),
// //                 icon: Icon(
// //                   Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
// //                 ),
// //               ),
// //             ),
// //             // body: GetBuilder<SearchController>(
// //             //   id: kSearchScreen,
// //             //   init: SearchController(),
// //             //   builder: (_controller) {
// //             //     return Container(
// //             body: Container(
// //               padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
// //               width: double.infinity,

// //               // child: Padding(
// //               //   padding: const EdgeInsets.all(8.0),
// //               //   child: SearchField(
// //               //     suggestionState: Suggestion.expand,
// //               //     suggestionAction: SuggestionAction.next,
// //               //     suggestions:
// //               //         _suggestions.map((e) => SearchFieldListItem(e)).toList(),
// //               //     textInputAction: TextInputAction.next,
// //               //     controller: _controller.searchTextController,
// //               //     hint: 'SearchField Example 1',
// //               //     // initialValue: SearchFieldListItem(_suggestions[2], SizedBox()),
// //               //     maxSuggestionsInViewPort: 3,
// //               //     itemHeight: 45,
// //               //     onSuggestionTap: (x) {},
// //               //   ),
// //               // ),
// //               // SearchField<String>(
// //               //   suggestions: _controller.str
// //               //       .map(
// //               //         (e) => SearchFieldListItem<String>(
// //               //           e.toString(),
// //               //           item: e,
// //               //         ),
// //               //       )
// //               //       .toList(),
// //               // ),
// //               child: DropdownSearch<String>(
// //                 maxHeight: 600,
// //                 showSearchBox: true,
// //                 showClearButton: true,
// //                 mode: Mode.MENU,
// //                 showAsSuffixIcons: true,
// //                 items: _controller.str,
// //                 label: "Search",
// //                 dropdownSearchBaseStyle: textStyle13Normal,
// //                 // itemAsString: (DependantListModel? _area) =>
// //                 //     _area!.message,
// //                 // calling on area selected method
// //                 // onChanged: (String? _dependant) => _controller
// //                 //     .onDependantSelected(dependant: _dependant),
// //                 emptyBuilder: (context, _searchString) =>
// //                     const Scaffold(body: NoRecordsFound()),
// //               ),
// //             ),
// //           );
// //         });
// //   }
// // }

// //==============================================================================================================

// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchScreen> {
//   String? _result;
//   final List<String> _statesOfIndia = [
//     "Employees",
//     "News",
//     "Hospitals",
//     "Apps",
//     "Sugam",
//     "Links",
//     "Offices",
//     "Vehicle Search",
//     "BIS Helpdesk",
//     "Guest House",
//     "Dashboard",
//     "Energy Calculator",
//     "Feedback",
//     "Cashless Medicine",
//     "Website",
//     "Intranet",
//     "Tenders",
//     "Mt GSTIN",
//     "My Library",
//     "WFH",
//     "Holiday List",
//     "Birthday",
//     "Profile Settings"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Search')),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text(_result ?? '', style: TextStyle(fontSize: 18)),
//             ElevatedButton(
//               onPressed: () async {
//                 var result = await showSearch<String>(
//                   context: context,
//                   delegate: CustomDelegate(),
//                 );
//                 setState(() => _result = result);
//               },
//               child: Text('Search'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomDelegate extends SearchDelegate<String> {
//   List<String> data = [
//     'Andhra Pradesh',
//     'Assam',
//     'Arunachal Pradesh',
//     'Bihar',
//     'Goa',
//     'Gujarat',
//     'Jammu and Kashmir',
//     'Jharkhand',
//     'West Bengal',
//     'Karnataka',
//     'Kerala',
//     'Madhya Pradesh',
//     'Maharashtra',
//     'Manipur',
//     'Meghalaya',
//     'Mizoram',
//     'Nagaland',
//     'Orissa',
//     'Punjab',
//     'Rajasthan',
//     'Sikkim',
//     'Tamil Nadu',
//     'Tripura',
//     'Uttaranchal',
//     'Uttar Pradesh',
//     'Haryana',
//     'Himachal Pradesh',
//     'Chhattisgarh'
//   ]; //nouns.take(100).toList();

//   @override
//   List<Widget> buildActions(BuildContext context) =>
//       [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//       icon: Icon(Icons.chevron_left), onPressed: () => close(context, ''));

//   @override
//   Widget buildResults(BuildContext context) => Container();

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var listToShow = data;
//     if (query.isNotEmpty)
//       listToShow = data.where((e) => e.contains(query)).toList();

//     return ListView.builder(
//       itemCount: listToShow.length,
//       itemBuilder: (_, i) {
//         var noun = listToShow[i];
//         return ListTile(
//           title: Text(noun),
//           onTap: () => close(context, noun),
//         );
//       },
//     );
//   }
// }
