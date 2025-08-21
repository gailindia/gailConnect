// Created By Amit Jangid 21/09/21

import 'dart:io';

import 'package:get/get.dart';
import 'package:multiutillib/utils/utils.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/update_app_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class AppVersionController extends GetxController {
  static AppVersionController get to => Get.find<AppVersionController>();

  String? currentAppVersion;

  @override
  void onInit() {
    super.onInit();

    // calling get app version method
    _getAppVersion();
  }

  _getAppVersion() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    late String _storeLink, _serverAppVersion;

    // calling get app version method
    currentAppVersion = await getAppVersion();
    update([kAppVersion]);

    if (Platform.isAndroid) {
      _storeLink = kPlayStoreUrl;
      _serverAppVersion = (await pref.getString("apkVersion",isEncrypted: true))!;
      print("_serverAppVersion android:: $_serverAppVersion");
    } else if (Platform.isIOS) {
      _storeLink = kAppStoreUrl;
      _serverAppVersion = (await pref.getString("iosVersion",isEncrypted: true))!;
      print("_serverAppVersion ios:: $_serverAppVersion");
      /*final Uri _uri = Uri(
        scheme: 'https',
        path: 'testiosappp.html',
        host: 'gailebank.gail.co.in',
        query: 'myParam:GAIL Connect',
      );

      final String _url = _uri.toString();
      debugPrint('url is: $_url');*/
    }
    print("_serverAppVersion ****:: $_serverAppVersion");
    final int _serverAppVer = int.parse(_serverAppVersion.replaceAll('.', ''));
    final int _currentAppVer =
        int.parse(currentAppVersion!.replaceAll('.', ''));

    if (_serverAppVer > _currentAppVer) {
      // calling update app dialog method
      updateAppDialog(context: Get.context!, storeLink: _storeLink);
    }
  }
}
