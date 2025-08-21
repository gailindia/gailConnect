import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../styles/color_controller.dart';

class CalculatorCrude extends StatefulWidget {
  const CalculatorCrude({Key? key}) : super(key: key);

  @override
  State<CalculatorCrude> createState() => _CalculatorCrudeState();
}

class _CalculatorCrudeState extends State<CalculatorCrude> {
  String resultA = '';
  String resultB = '';
  final TextEditingController _price = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  final TextEditingController _usdinr = TextEditingController();
  ColorController colorController= Get.put(ColorController());
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title:kCrudeHeading + " " + kCrudeOil),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     child: Text(kCrudeHeading + " " + kCrudeOil),
        //   ),
        //   centerTitle: true,
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
                      left: 12,
                      right: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _price,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kCrudePrice,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _usdinr,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kDollarConversionRate,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _kcal,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kCalorificValue2,
                      ),
                    ),
                  ),
                  resultCalculateWidget(resultA, resultB),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          bottom: 12,
                        ),
                        child: PrimaryButton(
                          text: kCalculate,
                          onPressed: _handleCalculation,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          bottom: 36,
                        ),
                        child: PrimaryButton(
                          text: kReset,
                          onPressed: reset,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resultCalculateWidget(resultA, resultB) {
    final String _resultA = resultA;
    final String _resultB = resultB;
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 48,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 6,
            ),
            child:  Text(
              kResultMT,
              style: TextStyle(
                  color: colorController.kPrimaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            _resultA,
            style:  TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 36,
                color: colorController.kPrimaryDarkColor,
                inherit: false),
          ),
          verticalSpace12,
          Container(
            padding: const EdgeInsets.only(
              top: 18,
              left: 12,
              right: 12,
              bottom: 6,
            ),
            child:  Text(
              kResultMMBTU,
              style: TextStyle(
                  color: colorController.kPrimaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            _resultB,
            style:  TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 36,
                color: colorController.kPrimaryDarkColor,
                inherit: false),
          ),
        ],
      ),
    );
  }

  void _handleCalculation() {
    if (_price.text.isEmpty || _usdinr.text.isEmpty || _kcal.text.isEmpty) {
      showCustomDialogBox(
        context: context,
        title: 'Empty fields!',
        description: 'Kindly fill all the desired fields.',
      );
      resultA = '';
      resultB = '';
    } else {
      final double price = double.parse(_price.text);
      final double usdinr = double.parse(_usdinr.text);
      final double kcal = double.parse(_kcal.text);
      final double res1 = price * usdinr * 7.3;
      final double res2 =
          (price * usdinr * 7.3 * 252000) / 1000 / kcal / usdinr;
      resultA = res1.toStringAsFixed(2);
      resultB = res2.toStringAsFixed(2);
    }
    setState(() {});
  }

  void reset() {
    _kcal.clear();
    _price.clear();
    _usdinr.clear();
    resultA = '';
    resultB = '';
    setState(() {});
  }
}
