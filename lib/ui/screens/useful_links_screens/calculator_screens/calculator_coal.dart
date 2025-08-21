import 'package:flutter/material.dart';

import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

import '../../../styles/color_controller.dart';

class CalculatorCoal extends StatefulWidget {
  const CalculatorCoal({Key? key}) : super(key: key);

  @override
  State<CalculatorCoal> createState() => _CalculatorCoalState();
}

class _CalculatorCoalState extends State<CalculatorCoal> {
  String result = '';
  final TextEditingController _price = TextEditingController();
  final TextEditingController _usdinr = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title:kCoalHeading + ' ' + kCoalF),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     child: Text(kCoalHeading + ' ' + kCoalF),
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
                      controller: _price,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kCoalPrice,
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
                      decoration: const InputDecoration(
                        labelText: kDollarConversionRate,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
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
                      decoration: const InputDecoration(
                        labelText: kCalorificValue2,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  resultCalculateWidget(result,colorController),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: PrimaryButton(
                            text: kCalculate,
                            width: double.infinity,
                            onPressed: _handleCalculation,
                          ),
                        ),
                        PrimaryButton(
                          text: kReset,
                          width: double.infinity,
                          onPressed: _handleReset,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resultCalculateWidget(result, ColorController colorController) {
    final String _result = result;
    return Container(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            child:  Text(
              kResultMMBTU,
              style: TextStyle(
                  color: colorController.kPrimaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              _result,
              style: //textStyle18UBold
                   TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 36,
                      color: colorController.kPrimaryDarkColor,
                      inherit: false),
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
      result = '';
    } else {
      final double price = double.parse(_price.text);
      final double usdinr = double.parse(_usdinr.text);
      final double kcal = double.parse(_kcal.text);
      final double res = (price * 252000) / 1000 / kcal / usdinr;
      result = res.toStringAsFixed(2);
    }
    setState(() {});
  }

  void _handleReset() {
    _kcal.clear();
    _price.clear();
    _usdinr.clear();
    result = '';
    setState(() {});
  }
}
