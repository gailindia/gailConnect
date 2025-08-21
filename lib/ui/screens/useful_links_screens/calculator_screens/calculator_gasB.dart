import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../widgets/custom_app_bar.dart';

class CalculatorGasB extends StatefulWidget {
  // CalculateGasB({Key? key}) : super(key: key);
  const CalculatorGasB({Key? key}) : super(key: key);

  @override
  State<CalculatorGasB> createState() => _CalculatorGasBState();
}

class _CalculatorGasBState extends State<CalculatorGasB> {
  String results = '';
  final TextEditingController _price = TextEditingController();
  final TextEditingController _usdinr = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  final TextEditingController _resultmt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title:kGasHeading + " " + kGas2),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: Text(
        //       kGasHeading + " " + kGas2,
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        // body: Center(child:
        body: SizedBox(
          height: double.infinity,
          child: MaterialCard(
            borderRadius: 12,
            margin: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                        labelText: kGasPrice2,
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
                        labelText: kCalorificValue1,
                      ),
                    ),
                  ),
                  resultCalculateWidget(results),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 48,
                    ),
                    child: PrimaryButton(
                      width: double.infinity,
                      text: kCalculate,
                      onPressed: _handleCalculation,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 48,
                    ),
                    child: PrimaryButton(
                      width: double.infinity,
                      text: kReset,
                      onPressed: _handleReset,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }

  Widget resultCalculateWidget(result) {
    final String _result = result;
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 48,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            kResultSCM,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
          Text(
            _result,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: Colors.black,
            ),
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
          description: 'Kindly fill all the desired fields.');
      _resultmt.text = '';
      results = '';
    } else {
      final double price = double.parse(_price.text);
      final double usdinr = double.parse(_usdinr.text);
      final double kcal = double.parse(_kcal.text);
      final double res = ((price * usdinr * kcal) / 252000);
      results = res.toStringAsFixed(4);
    }

    setState(() {});
  }

  void _handleReset() {
    _kcal.clear();
    _price.clear();
    _usdinr.clear();
    _resultmt.text = '';
    results = '';
    setState(() {});
  }
}
