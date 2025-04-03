// Created By Amit Jangid 18/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/otp_controller.dart';

import '../../styles/color_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kEnterOtp),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<OtpController>(
          id: kOtp,
          init: OtpController(),
          builder: (_otpController) {
            if (_otpController.showOtpScreen) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  verticalSpace12,
                  Text(kVerificationCode,
                      style: textStyle24Bold, textAlign: TextAlign.center),
                  verticalSpace12,
                  Text(
                    '$kMsgPleaseEnterOtpSent ${_otpController.mobileNoDisplay}',
                    style: textStyle14Normal,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace12,
                  const Image(height: 60, image: AssetImage(kIconOtp)),
                  const Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _otpTextField(_otpController, colorController)),
                  if (_otpController.isOtpSent) ...[
                    verticalSpace6,
                    // calling send otp method
                    PrimaryButton(
                        text: kResendOtp,
                        onPressed: () => _otpController.sendOtp(reOtp: true)),
                  ],
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _otpKeyboardInputButton(
                          label: "1",
                          onPressed: () => _otpController.setCurrentDigit(1)),
                      _otpKeyboardInputButton(
                          label: "2",
                          onPressed: () => _otpController.setCurrentDigit(2)),
                      _otpKeyboardInputButton(
                          label: "3",
                          onPressed: () => _otpController.setCurrentDigit(3)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _otpKeyboardInputButton(
                          label: "4",
                          onPressed: () => _otpController.setCurrentDigit(4)),
                      _otpKeyboardInputButton(
                          label: "5",
                          onPressed: () => _otpController.setCurrentDigit(5)),
                      _otpKeyboardInputButton(
                          label: "6",
                          onPressed: () => _otpController.setCurrentDigit(6)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _otpKeyboardInputButton(
                          label: "7",
                          onPressed: () => _otpController.setCurrentDigit(7)),
                      _otpKeyboardInputButton(
                          label: "8",
                          onPressed: () => _otpController.setCurrentDigit(8)),
                      _otpKeyboardInputButton(
                          label: "9",
                          onPressed: () => _otpController.setCurrentDigit(9)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const SizedBox(width: 80),
                      _otpKeyboardInputButton(
                          label: "0",
                          onPressed: () => _otpController.setCurrentDigit(0)),
                      _otpKeyboardActionButton(
                        // calling on back button pressed method
                        onPressed: _otpController.onBackButtonPressed,
                        label: Icon(Icons.backspace,
                            color: colorController.kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  Center(
                    child: CustomPaint(
                      size: const Size(260, 260),
                      painter: DrawTriangleShape(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        verticalSpace48,
                        Center(
                          child: Image(
                            width: 60,
                            color: colorController.kPrimaryColor,
                            image: AssetImage(kIconUnderConstruction),
                          ),
                        ),
                        verticalSpace12,
                        Center(
                            child: Column(
                          children: [
                            TextWidget(
                              status: 'Not',
                              fontSize: 24,
                              letterSpacing: 0.55,
                              color: colorController.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            TextWidget(
                              status: 'Authorized',
                              fontSize: 24,
                              letterSpacing: 0.55,
                              color: colorController.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        )
                            // Text("Not\nAuthorized",
                            //     style: textStyle24Bold,
                            //     textAlign: TextAlign.center)
                            ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  /// Returns "Otp text field"
  List<Widget> _otpTextField(
      OtpController _otpController, ColorController colorController) {
    final List<Widget> _otpTextFieldList = [];

    for (int i = 0; i < _otpController.otpLength; i++) {
      _otpTextFieldList.add(
        Container(
            width: 35,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2.0, color: colorController.kPrimaryColor))),
            child: TextWidget(
              status: _otpController.otpValue[i],
              fontSize: 24,
              letterSpacing: 0.55,
              color: colorController.kPrimaryColor,
              fontWeight: FontWeight.w600,
            )

            // Text(
            //   _otpController.otpValue[i],
            //   style: textStyle24Bold,
            //   textAlign: TextAlign.center,
            // ),
            ),
      );
    }

    return _otpTextFieldList;
  }

  Widget _otpKeyboardInputButton(
      {required String label, required VoidCallback onPressed}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            width: 80.0,
            height: 55.0,
            decoration: const BoxDecoration(),
            child: Center(
                child: TextWidget(
              status: label,
              fontSize: 24,
              letterSpacing: 0.55,
              color: colorController.kPrimaryColor,
              fontWeight: FontWeight.w600,
            )
                // Text(label,
                //     style: textStyle24Bold.copyWith(color: Colors.black))),
                ),
          ),
        ));
  }

  Widget _otpKeyboardActionButton(
      {required Widget label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80.0,
        height: 55.0,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Center(child: label),
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  ColorController colorController = Get.put(ColorController());
  late Paint _painter;

  DrawTriangleShape() {
    _painter = Paint()
      ..color = colorController.kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final _path = Path();

    _path.moveTo(size.width / 2, 0);
    _path.lineTo(0, size.height);
    _path.lineTo(size.height, size.width);
    _path.close();

    canvas.drawPath(_path, _painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
