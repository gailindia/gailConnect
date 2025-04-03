// Created By Amit Jangid 15/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/feedback.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class DropdownQuest extends StatefulWidget {
  final MFeedback feedback;

  const DropdownQuest({Key? key, required this.feedback}) : super(key: key);

  @override
  _DropdownQuestState createState() => _DropdownQuestState();
}

class _DropdownQuestState extends State<DropdownQuest> {
  String _selectedAns = '';

  @override
  void initState() {
    super.initState();

    _selectedAns = widget.feedback.questOptionList[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      borderRadius: 12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.feedback.questionText!, style: textStyle16Bold),
          verticalSpace18,
          DropdownButtonFormField<String>(
            value: _selectedAns,
            // calling on changed method
            onChanged: _onChanged,
            hint: Text(kSelect, style: textStyle14Normal.copyWith(color: Colors.grey)),
            items: widget.feedback.questOptionList
                .map((QuestOption _questOption) => DropdownMenuItem<String>(
                    value: _questOption.value, child: Text(_questOption.value!, style: textStyle14Normal)))
                .toList(),
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
