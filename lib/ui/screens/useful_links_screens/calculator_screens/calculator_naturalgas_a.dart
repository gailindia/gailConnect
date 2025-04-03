import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class CalculatorNGasA extends StatefulWidget {
  const CalculatorNGasA({Key? key}) : super(key: key);

  @override
  State<CalculatorNGasA> createState() => _CalculatorNGasAState();
}

class _CalculatorNGasAState extends State<CalculatorNGasA> {
  String result = '';
  final TextEditingController _naturalgas = TextEditingController();
  final TextEditingController _specificenergy = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title: kNaturalGasHeading + " " + kNaturalGas1),
        // appBar: AppBar(
        //   title: const FittedBox(
        //     child: FittedBox(
        //       child: Text(
        //         kNaturalGasHeading + " " + kNaturalGas1,
        //       ),
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
                      decoration: const InputDecoration(
                        labelText: kNaturalGas1,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 24,
                    ),
                    child: TextField(
                      controller: _specificenergy,
                      decoration: const InputDecoration(
                        labelText: kNaturalGasA2,
                      ),
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
                      onPressed: _handleCalculation,
                      width: double.infinity,
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

  resultCalculateWidget(String result) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 36,
            right: 12,
            left: 12,
            bottom: 6,
          ),
          child: const Text(
            kNaturalGasA3,
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
    if (_naturalgas.text.isEmpty || _specificenergy.text.isEmpty) {
      showCustomDialogBox(
          context: context,
          title: 'Empty fields!',
          description: 'Kindly fill all the desired fields.');
      result = '';
    } else {
      final double naturalgas = double.parse(_naturalgas.text);
      final double sEnergy = double.parse(_specificenergy.text);
      final double res = (naturalgas * 8600 * 365) / (sEnergy * 1000000);
      result = res.toStringAsFixed(2);
    }

    setState(() {});
  }

  void _handleReset() {
    _specificenergy.clear();
    _naturalgas.clear();
    result = '';
    setState(() {});
  }
}
