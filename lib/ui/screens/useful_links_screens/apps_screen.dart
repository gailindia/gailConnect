// Created By Amit Jangid 31/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/apps_tab_bar_view_widget.dart';


class UsefulApps extends StatelessWidget {
  const UsefulApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      // appBar: CustomAppBar(
      //   title: kUsefulApps,
      // ),
      body: const TabBarViewWidget(),
    );
  }
}
