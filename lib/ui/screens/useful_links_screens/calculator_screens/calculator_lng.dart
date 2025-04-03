import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class CalculatorLNG extends StatefulWidget {
  const CalculatorLNG({Key? key}) : super(key: key);

  @override
  State<CalculatorLNG> createState() => _CalculatorLNGState();
}

class _CalculatorLNGState extends State<CalculatorLNG> {
  String result = '';
  final TextEditingController _lngmmtpa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(
          title: kLNGHeading + " " + kLNG,
        ),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     child: Text(
        //       kLNGHeading + " " + kLNG,
        //     ),
        //   ),
        // ),
        body: SizedBox(
          height: double.infinity,
          child: MaterialCard(
            borderRadius: 12,
            margin: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 24,
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _lngmmtpa,
                      decoration: const InputDecoration(labelText: kLngMMTPA),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  resultCalculateWidget(result),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: PrimaryButton(
                        text: kCalculate,
                        width: double.infinity,
                        onPressed: _handleCalculation),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: PrimaryButton(
                      text: kReset,
                      width: double.infinity,
                      onPressed: _handleReset,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resultCalculateWidget(result) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            bottom: 6,
          ),
          child: const Text(
            kNaturalGasA1,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            bottom: 48,
          ),
          child: Text(
            result,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _handleCalculation() {
    if (_lngmmtpa.text.isEmpty) {
      showCustomDialogBox(
          context: context,
          title: 'Empty fields!',
          description: 'Kindly fill all the desired fields.');
      result = '';
    } else {
      final double lngmmtpa = double.parse(_lngmmtpa.text);
      final double res = (lngmmtpa * 1000000 * 1.4 * 1000) / 365 / 1000000;
      result = res.toStringAsFixed(2);
    }

    setState(() {});
  }

  void _handleReset() {
    _lngmmtpa.clear();
    result = '';
    setState(() {});
  }
}
