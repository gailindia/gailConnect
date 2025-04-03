import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class CalculatorNaptha extends StatefulWidget {
  const CalculatorNaptha({Key? key}) : super(key: key);

  @override
  State<CalculatorNaptha> createState() => _CalculatorNapthaState();
}

class _CalculatorNapthaState extends State<CalculatorNaptha> {
  String result = '';
  final TextEditingController _price = TextEditingController();
  final TextEditingController _usdinr = TextEditingController();
  final TextEditingController _kcal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return  GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: colorController.kHomeBgColor,
            appBar: CustomAppBar(title: kNapthaHeading + " " + kNaptha,),
            // appBar: AppBar(
            //   title: const Text(
            //     kNapthaHeading + " " + kNaptha,
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
                          controller: _price,
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: kNapthaPrice,
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
                          right: 12,
                          left: 12,
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
                      resultCalculateWidget(result),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 48,
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
                          width: double.infinity,
                          onPressed: _handleReset,
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
            kResultMMBTU,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
        Text(
          result,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
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
    _price.clear();
    _kcal.clear();
    _usdinr.clear();
    result = '';
    setState(() {});
  }
}
