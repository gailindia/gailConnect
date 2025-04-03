// Created By Amit Jangid 14/09/21

// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/fresher_zone_controller.dart';

import 'package:get/get.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../styles/color_controller.dart';

class FresherZoneScreen extends StatelessWidget {
  const FresherZoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: kWelcomeTrainees),
        body: GetBuilder<FresherZoneController>(
          id: kFresherZone,
          init: FresherZoneController(),
          builder: (_fzController) {
            return ListView(
              padding: const EdgeInsets.only(left: 8, right: 8),
              children: [
                MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(0),
                  child: TextField(
                    controller: _fzController.searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _fzController.clearFZ();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _fzController.searchFZ(value);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                //   child: Container(
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Colors.amber,
                //         borderRadius: BorderRadius.all(Radius.circular(10),),
                //         // border: Border.all(
                //         //   width: 10,
                //         //   color: Colors.amber,
                //         // ),
                //       ),
                //       child: Row(
                //         // ignore: prefer_const_literals_to_create_immutables
                //         children: [
                //           Expanded(flex: 2, child: Center(child: Text("SNo"),),),
                //           // Spacer(),
                //           Expanded(flex: 4, child: Text("Module"),),
                //           // Spacer(),
                //           Expanded(flex: 2, child: Text("Path"),),
                //           // Spacer(),
                //           Expanded(flex: 2, child: Text("Link"),),
                //         ],
                //       ),),
                // ),
                // _fzController.usersFiltered.isEmpty
                // ? ListView.builder(
                //     itemCount: _fzController.fresherzoneList.length,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(
                //             left: 5.0, right: 5.0, top: 10),
                //         child: Container(
                //             height: MediaQuery.of(context).size.height *
                //                 0.05, //40,
                //             decoration: BoxDecoration(
                //               color: Color.fromARGB(255, 241, 233, 211),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8),),
                //               // border: Border.all(
                //               //   width: 10,
                //               //   color: Colors.amber,
                //               // ),
                //             ),
                //             // decoration: BoxDecoration(
                //             //   color: Colors.amber,
                //             //   borderRadius: BorderRadius.all(Radius.circular(10),),
                //             //   // border: Border.all(
                //             //   //   width: 10,
                //             //   //   color: Colors.amber,
                //             //   // ),
                //             // ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               // ignore: prefer_const_literals_to_create_immutables
                //               children: [
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // width: 20,
                //                     // color: Colors.blue,
                //                     child: Center(
                //                       child: Text(_fzController
                //                           .fresherzoneList[index].sno!
                //                           .round()
                //                           .toString(),),
                //                     ),
                //                   ),
                //                 ),

                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 4,
                //                   child: Container(
                //                     padding: const EdgeInsets.only(right: 4),
                //                     // color: Colors.white,
                //                     // width: MediaQuery.of(context).size.width *
                //                     //     0.3,
                //                     // padding: EdgeInsets.only(right: 0.0),
                //                     child: Text(
                //                       _fzController
                //                           .fresherzoneList[index].module
                //                           .toString(),
                //                       maxLines: 1,
                //                       overflow: _fzController
                //                                   .fresherzoneList[index]
                //                                   .module
                //                                   .toString()
                //                                   .length >
                //                               20
                //                           ? TextOverflow.ellipsis
                //                           : null,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.normal,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Text(
                //                 //   _fzController.fresherzoneList[index].module
                //                 //       .toString(),
                //                 //   overflow: TextOverflow.ellipsis,
                //                 // ),
                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // color: Colors.green,
                //                     // width: 50,
                //                     padding:
                //                         EdgeInsets.only(left: 3, right: 3),
                //                     child: Text(
                //                       _fzController
                //                           .fresherzoneList[index].pathToAccess
                //                           .toString(),
                //                       overflow: TextOverflow.ellipsis,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Text(_fzController
                //                 //     .fresherzoneList[index].pathToAccess
                //                 //     .toString(),),
                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // color: Colors.orange,
                //                     // width: 50,
                //                     padding:
                //                         EdgeInsets.only(left: 3, right: 3),
                //                     child: Text(
                //                       _fzController
                //                           .fresherzoneList[index].link
                //                           .toString(),
                //                       overflow: TextOverflow.ellipsis,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Padding(
                //                 //   padding: const EdgeInsets.only(right: 40.0),
                //                 //   child: Text(_fzController
                //                 //       .fresherzoneList[index].link
                //                 //       .toString(),),
                //                 // ),
                //               ],
                //             ),),
                //       );
                //     },)
                // : ListView.builder(
                //     itemCount: _fzController.usersFiltered.length,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(
                //             left: 5.0, right: 5.0, top: 10),
                //         child: Container(
                //             height: MediaQuery.of(context).size.height *
                //                 0.05, //40,
                //             decoration: BoxDecoration(
                //               color: Color.fromARGB(255, 241, 233, 211),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8),),
                //               // border: Border.all(
                //               //   width: 10,
                //               //   color: Colors.amber,
                //               // ),
                //             ),
                //             // decoration: BoxDecoration(
                //             //   color: Colors.amber,
                //             //   borderRadius: BorderRadius.all(Radius.circular(10),),
                //             //   // border: Border.all(
                //             //   //   width: 10,
                //             //   //   color: Colors.amber,
                //             //   // ),
                //             // ),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               // ignore: prefer_const_literals_to_create_immutables
                //               children: [
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // width: 20,
                //                     // color: Colors.blue,
                //                     child: Center(
                //                       child: Text(_fzController
                //                           .usersFiltered[index].sno!
                //                           .round()
                //                           .toString(),),
                //                     ),
                //                   ),
                //                 ),

                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 4,
                //                   child: Container(
                //                     padding: const EdgeInsets.only(right: 4),
                //                     // color: Colors.white,
                //                     // width: MediaQuery.of(context).size.width *
                //                     //     0.3,
                //                     // padding: EdgeInsets.only(right: 0.0),
                //                     child: Text(
                //                       _fzController
                //                           .usersFiltered[index].module
                //                           .toString(),
                //                       maxLines: 1,
                //                       overflow: _fzController
                //                                   .usersFiltered[index].module
                //                                   .toString()
                //                                   .length >
                //                               20
                //                           ? TextOverflow.ellipsis
                //                           : null,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.normal,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Text(
                //                 //   _fzController.fresherzoneList[index].module
                //                 //       .toString(),
                //                 //   overflow: TextOverflow.ellipsis,
                //                 // ),
                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // color: Colors.green,
                //                     // width: 50,
                //                     padding:
                //                         EdgeInsets.only(left: 3, right: 3),
                //                     child: Text(
                //                       _fzController
                //                           .usersFiltered[index].pathToAccess
                //                           .toString(),
                //                       overflow: TextOverflow.ellipsis,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Text(_fzController
                //                 //     .fresherzoneList[index].pathToAccess
                //                 //     .toString(),),
                //                 // Spacer(),
                //                 Expanded(
                //                   flex: 2,
                //                   child: Container(
                //                     // color: Colors.orange,
                //                     // width: 50,
                //                     padding:
                //                         EdgeInsets.only(left: 3, right: 3),
                //                     child: Text(
                //                       _fzController.usersFiltered[index].link
                //                           .toString(),
                //                       overflow: TextOverflow.ellipsis,
                //                       style: TextStyle(
                //                         fontSize: 13.0,
                //                         fontFamily: 'Roboto',
                //                         color: Color(0xFF212121),
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 // Padding(
                //                 //   padding: const EdgeInsets.only(right: 40.0),
                //                 //   child: Text(_fzController
                //                 //       .fresherzoneList[index].link
                //                 //       .toString(),),
                //                 // ),
                //               ],
                //             ),),
                //       );
                //     },),

                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: _width),
                    child: DataTable(
                      // decoration: BoxDecoration(
                      //   color: Colors.amber,
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(40),
                      //   ),
                      // border: Border.all(
                      //   width: 10,
                      //   color: Colors.amber,
                      // ),
                      // ),
                      border: TableBorder.all(
                        width: 2.0,
                        color: Color.fromARGB(95, 154, 154, 154),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // dataRowColor: MaterialStateProperty.resolveWith(
                      //   (states) => Color.fromARGB(255, 0, 98, 255),
                      // ),
                      // dataRowHeight: ,
                      // sortAscending: true,
                      // sortColumnIndex: 0,
                      // dividerThickness: _height * 0.009,
                      // dataRowHeight: _height * 0.13,
                      // showBottomBorder: true,
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorController.kPrimaryDarkColor),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => colorController.kPrimaryColor),
                      columnSpacing: _width * 0.05,
                      columns: <DataColumn>[
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: _width * 0.2),
                            child: Text(
                              "SNo.",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: _width * 0.4),
                            child: Text(
                              'MODULE',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: _width * 0.2),
                            child: Text(
                              'PATH',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: _width * 0.3),
                            child: Text(
                              'LINK',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: _fzController.usersFiltered.isEmpty
                          ? List.generate(
                              _fzController.fresherzoneList.length,
                              (index) => DataRow(
                                color: MaterialStateProperty.resolveWith(
                                  (states) => Color.fromARGB(70, 253, 255, 129),
                                ),
                                cells: <DataCell>[
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: Text(
                                        //"10"
                                        _fzController
                                            .fresherzoneList[index].sno!
                                            .round()
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.3),
                                      child: Text(
                                        // "hello",
                                        _fzController
                                            .fresherzoneList[index].module
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: Text(
                                        // "path",
                                        _fzController
                                            .fresherzoneList[index].pathToAccess
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: _fzController
                                                            .fresherzoneList[
                                                                index]
                                                            .link
                                                            .toString() ==
                                                        "null"
                                                    ? Colors.black87
                                                    : Colors.blue),
                                            text: _fzController
                                                        .fresherzoneList[index]
                                                        .link
                                                        .toString() ==
                                                    "null"
                                                ? " "
                                                : "Link",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(
                                                  _fzController
                                                      .fresherzoneList[index]
                                                      .link
                                                      .toString(),
                                                );
                                              },
                                          ),
                                        ]),
                                      ),
                                      // Text(
                                      //   "link",
                                      //   // _fzController
                                      //   //     .fresherzoneList[index].link
                                      //   //     .toString(),
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : List.generate(
                              _fzController.usersFiltered.length,
                              (index) => DataRow(
                                color: MaterialStateProperty.resolveWith(
                                  (states) => Color.fromARGB(70, 253, 255, 129),
                                ),
                                cells: <DataCell>[
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: Text(
                                        // "11",
                                        _fzController
                                            .fresherzoneList[index].sno!
                                            .round()
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.3),
                                      child: Text(
                                        // "module",
                                        _fzController
                                            .usersFiltered[index].module
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: Text(
                                        // "path",
                                        _fzController
                                            .usersFiltered[index].pathToAccess
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: _width * 0.2),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: _fzController
                                                            .usersFiltered[
                                                                index]
                                                            .link
                                                            .toString() ==
                                                        "null"
                                                    ? Colors.black87
                                                    : Colors.blue),
                                            text: _fzController
                                                        .fresherzoneList[index]
                                                        .link
                                                        .toString() ==
                                                    "null"
                                                ? " "
                                                : "Link",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(_fzController
                                                    .fresherzoneList[index].link
                                                    .toString());
                                              },
                                          ),
                                        ]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            );
            // _fzController.isLoading
            //     ? const LoadingWidget()
            //     : _fzController.fresherzoneList.isNotEmpty
            //         ? ListView.builder(
            //             itemCount: _fzController.fresherzoneList.length,
            //             padding:
            //                 const EdgeInsets.only(left: 6, right: 6, bottom: 48),
            //             itemBuilder: (context, _position) {
            //               final FresherZoneModel _fresherZoneDetails =
            //                   _fzController.fresherzoneList[_position];
            //               return Text("dfghjk");
            //             },
            //           )
            //         : const NoRecordsFound();
          },
        ),
      ),
    );
  }
}
