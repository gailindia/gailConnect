/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../core/controllers/useful_links_controllers/useful_links_controller.dart';
import '../widgets/custom_app_bar.dart';

class PdfViewer extends StatefulWidget {
  String pdfurl, title, type;
  PdfViewer(
      {Key? key, required this.pdfurl, required this.title, required this.type})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _PdfViewer();
}

class _PdfViewer extends State<PdfViewer> {
  late final WebViewController _controller;
  late WebKitWebViewController controllers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ?..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          // onWebResourceError: (WebResourceError error) {
          //   debugPrint('''
          //                                                           Page resource error:
          //                                                             code: ${error.errorCode}
          //                                                             description: ${error.description}
          //                                                             errorType: ${error.errorType}
          //                                                             isForMainFrame: ${error.isForMainFrame}
          //                                                                     ''');
          // },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      );
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
    }
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    print("URL :: ${widget.pdfurl}   ${widget.type}");
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<UsefulLinksController>(
        id: kUsefulLinks,
        init: UsefulLinksController(),
        builder: (_usefulLinksController) {
          return Scaffold(
            backgroundColor: colorController.kBgPopupColor,
            appBar: CustomAppBar(title: widget.title),

            ///TODO:: change webciew
            body: Container(
                child: widget.type == "pdf"
                    ? const PDF(
                        enableSwipe: true,
                        autoSpacing: true,
                        pageFling: false,
                      ).fromUrl(
                        widget.pdfurl,
                        placeholder: (double progress) =>
                            Center(child: Text('$progress %')),
                        errorWidget: (dynamic error) =>
                            Center(child: Text(error.toString())),
                      )
                    : widget.pdfurl.contains("youtube") ||
                            widget.type == "sugamUrl" ||
                            widget.type.contains("nic")
                        ?
                        // Platform.isAndroid?
                        // WebViewWidget(controller: _controller..loadRequest(Uri.parse(widget.pdfurl))):
                        /*Container(
                  child: Center(
                    child: Text("${widget.pdfurl}"),
                  ),
                )*/
                        ///TODO :: inappwebview
                        InAppWebView(
                            initialUrlRequest:
                                URLRequest(url: WebUri(widget.pdfurl)),
                          )
                        : Platform.isAndroid
                            ? WebViewWidget(
                                controller: WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..loadFlutterAsset(widget.pdfurl))
                            : SafeArea(
                                child: WebViewWidget(
                                    controller: WebViewController()
                                      ..setJavaScriptMode(
                                          JavaScriptMode.unrestricted)
                                      ..loadFlutterAsset(widget.pdfurl)))),
          );
        });
  }
}
