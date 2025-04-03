import 'package:flutter/material.dart';

import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../styles/color_controller.dart';
import '../../../widgets/custom_app_bar.dart';

class CalculatorGasA extends StatefulWidget {
  const CalculatorGasA({Key? key}) : super(key: key);
  @override
  _CalculatorGasAState createState() => _CalculatorGasAState();
}

class _CalculatorGasAState extends State<CalculatorGasA> {
  String results = '';
  bool canShow = false;
  final TextEditingController _price = TextEditingController();
  final TextEditingController _usdinr = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  final TextEditingController _resultc = TextEditingController();
  ColorController colorController= Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title:kGasHeading + " " + kGas1),
        // appBar: AppBar(
        //   title: const Text(kGasHeading + " " + kGas1),
        //   centerTitle: true,
        // ),
        body: Container(
          height: double.infinity,
          child: MaterialCard(
            padding: const EdgeInsets.all(0),
            color: colorController.kPrimaryColor,
            borderRadius: 18,
            margin: const EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: 12,
            ),
            child: Container(
              color: Color.fromARGB(255, 241, 241, 241),
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          top: 24, left: 12, right: 12, bottom: 48),
                      child: TextField(
                        controller: _price,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration:
                            const InputDecoration(labelText: kGasPrice1),
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                            labelText: kDollarConversionRate),
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration:
                            const InputDecoration(labelText: kCalorificValue1),
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
        ),
        // ),
      ),
    );
    // );
  }

  Widget resultCalculateWidget(result) {
    final String _result = result;
    if (_result.isNotEmpty) {
      canShow = true;
    }
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 48,
      ),
      // child: canShow?
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text(
            kResultMMBTU,
            style: TextStyle(
                color: colorController.kPrimaryDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
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
      _resultc.text = '';
      results = '';
    } else {
      final double price = double.parse(_price.text);
      final double usdinr = double.parse(_usdinr.text);
      final double kcal = double.parse(_kcal.text);
      final double res = ((price * 252000) / kcal / usdinr);
      // _resultc.text = res.toString();
      results = res.toStringAsFixed(2);
    }

    setState(() {});
  }

  void _handleReset() {
    _kcal.clear();
    _price.clear();
    _usdinr.clear();
    _resultc.text = '';
    results = '';
    setState(() {});
  }
}
