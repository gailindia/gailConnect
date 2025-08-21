// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/tab_bar_view_widget.dart';


class UsefulLinks extends StatelessWidget {

    UsefulLinks({Key? key,required this.isSearch}) : super(key: key);
   bool isSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: CustomAppBar(
      //   title: kUsefulLinks,
      // ),
      body:  TabBarViewWidget(isSearch: isSearch,),
    );
  }
}
