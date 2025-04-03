// Created By Amit Jangid 03/09/21

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/core/controllers/browser_controller.dart';

class BrowserScreen extends StatelessWidget {
  const BrowserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrowserController>(
      id: kBrowserRoute,
      init: BrowserController(),
      builder: (_browserController) => Scaffold(
        appBar: CustomAppBar(title: _browserController.title),
        body: Stack(
          children: [
            // WebView(
            //   initialUrl: _browserController.initialUrl,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onPageStarted: (_url) => _browserController.onPageFinished(loading: true),
            //   onPageFinished: (_url) => _browserController.onPageFinished(loading: false),
            // ),
            if (_browserController.isLoading) ...[
              const LoadingWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
