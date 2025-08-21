import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class CalculatorOil extends StatefulWidget {
  const CalculatorOil({Key? key}) : super(key: key);

  @override
  State<CalculatorOil> createState() => _CalculatorOilState();
}

class _CalculatorOilState extends State<CalculatorOil> {
  String result = '';
  final TextEditingController _oil = TextEditingController();
  final TextEditingController _kcalOil = TextEditingController();
  final TextEditingController _kcalNg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title: kOilHeading + " " + kOil),
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: const FittedBox(
        //     child: Text(
        //       kOilHeading + ' ' + kOil,
        //     ),
        //   ),
        // ),
        body: SizedBox(
          height: double.infinity,
          child: MaterialCard(
            margin: const EdgeInsets.all(12),
            borderRadius: 12,
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
                      controller: _oil,
                      decoration: const InputDecoration(labelText: kOil1),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _kcalOil,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kCalorificValue3,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _kcalNg,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kCalorificValue4,
                      ),
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
                      onPressed: _handleCalculation,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: PrimaryButton(
                      width: double.infinity,
                      text: kReset,
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
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ),
      ],
    );
  }

  void _handleCalculation() {
    if (_oil.text.isEmpty || _kcalOil.text.isEmpty || _kcalNg.text.isEmpty) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: context,
          title: 'Empty fields!',
          description: 'Kindly fill all the desired fields.');
      result = '';
    } else {
      final double oil = double.parse(_oil.text);
      final double kcalOil = double.parse(_kcalOil.text);
      final double kcalNg = double.parse(_kcalNg.text);
      final double res = (oil * kcalOil * 1000000) / kcalNg / 365 / 1000;
      result = res.toStringAsFixed(2);
    }
    setState(() {});
  }

  void _handleReset() {
    _oil.clear();
    _kcalOil.clear();
    _kcalNg.clear();
    result = '';
    setState(() {});
  }
}
