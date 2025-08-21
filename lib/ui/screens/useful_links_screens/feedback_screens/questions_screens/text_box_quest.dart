// Created By Amit Jangid 15/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/feedback.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/feedback_controller.dart';

class TextBoxQuest extends StatefulWidget {
  final MFeedback feedback;

  const TextBoxQuest({Key? key, required this.feedback}) : super(key: key);

  @override
  _TextBoxQuestState createState() => _TextBoxQuestState();
}

class _TextBoxQuestState extends State<TextBoxQuest> {
  final TextEditingController _ansController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      borderRadius: 12,
      child: GetBuilder<FeedbackController>(
        id: kFeedback,
        builder: (_feedbackController) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.feedback.questionText!, style: textStyle16Bold),
            verticalSpace18,
            TextField(
              minLines: 3,
              maxLines: 5,
              controller: _ansController,
              onChanged: (_text) => widget.feedback.ansText = _text,
              decoration: const InputDecoration(hintText: kEnterYourAnswer, contentPadding: EdgeInsets.all(12)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ansController.dispose();

    super.dispose();
  }
}
