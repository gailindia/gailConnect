// Created By Amit Jangid 15/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/feedback.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

import '../../../../styles/color_controller.dart';

class RadioBtnQuest extends StatefulWidget {
  final MFeedback feedback;

  const RadioBtnQuest({Key? key, required this.feedback}) : super(key: key);

  @override
  _RadioBtnQuestState createState() => _RadioBtnQuestState();
}

class _RadioBtnQuestState extends State<RadioBtnQuest> {
  String _selectedAns = '';

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return MaterialCard(
      borderRadius: 12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.feedback.questionText!, style: textStyle16Bold, textAlign: TextAlign.center),
          verticalSpace18,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.feedback.questOptionList.map(
              (QuestOption _questOption) {
                if (_questOption.isAnsSelected) {
                  _selectedAns = _questOption.value!;
                }

                return RadioListTile(
                  dense: true,
                  onChanged: _onChanged,
                  groupValue: _selectedAns,
                  value: _questOption.value!,
                  activeColor: colorController.kPrimaryDarkColor,
                  contentPadding: const EdgeInsets.only(),
                  title: Text(_questOption.value!, style: textStyle14Normal),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  _onChanged(String? _answer) {
    for (final QuestOption _questOption in widget.feedback.questOptionList) {
      _questOption.isAnsSelected = false;

      if (_questOption.value!.toLowerCase() == _answer!.toLowerCase()) {
        _questOption.isAnsSelected = true;
      }
    }

    setState(() => _selectedAns = _answer!);
  }
}
