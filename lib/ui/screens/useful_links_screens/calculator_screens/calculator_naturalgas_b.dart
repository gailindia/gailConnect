import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class CalculatorNGasB extends StatefulWidget {
  const CalculatorNGasB({Key? key}) : super(key: key);

  @override
  State<CalculatorNGasB> createState() => _CalculatorNGasBState();
}

class _CalculatorNGasBState extends State<CalculatorNGasB> {
  String result = '';
  final TextEditingController _naturalgas = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  final TextEditingController _efficiency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(
          title: kNaturalGasHeading + " " + kNaturalGas2,
        ),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     child: Text(
        //       kNaturalGasHeading + '' + kNaturalGas2,
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
                      controller: _naturalgas,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kNaturalGasA1,
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
                  Container(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      bottom: 48,
                    ),
                    child: TextField(
                      controller: _efficiency,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: kNaturalGasB3,
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
                      text: kReset,
                      onPressed: _handleReset,
                      width: double.infinity,
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
            kResultPMW,
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

  _handleCalculation() {
    if (_naturalgas.text.isEmpty || _kcal.text.isEmpty || _kcal.text.isEmpty) {
      showCustomDialogBox(
          context: context,
          title: 'Empty fields!',
          description: 'Kindly fill all the desired fields.');
      result = '';
    } else {
      final double naturalgas = double.parse(_naturalgas.text);
      final double kcal = double.parse(_kcal.text);
      final double efficiency = double.parse(_efficiency.text);
      final double res = (naturalgas * kcal * efficiency * 10 * 0.001163) / 24;
      result = res.toStringAsFixed(2);
    }

    setState(() {});
  }

  _handleReset() {
    _naturalgas.clear();
    _kcal.clear();
    _efficiency.clear();
    result = '';
    setState(() {});
  }
}
