import 'dart:io';

import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class StepController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Health().configure(useHealthConnectIfAvailable: true);
    // _requestPermission();
    if (Platform.isIOS) {
      authorize();
    }
  }

  _requestPermission() async {
    await [Permission.activityRecognition].request();

    // if(await Permission.activityRecognition.status.isGranted){
    //   await initializeService();
    // }else{
    //   checkPermission();
    // }
  }

  static final types = [HealthDataType.STEPS];

  final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();
  // create a HealthFactory for use in the app
  final health = Health();
  // HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  Future authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    await health.configure();

    // Check if we have health permissions
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    hasPermissions = false;

    bool authorized = false;

    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {}
    }

    // setState(() => _state =
    // (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);

    // if(authorized){
    //   HealthController().fetchStepData();
    // }
  }
}
