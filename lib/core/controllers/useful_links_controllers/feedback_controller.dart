// Created By Amit Jangid 09/09/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/models/feedback_questions_model.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/feedback.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/feedback_screens/questions_screens/dropdown_quest.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/feedback_screens/questions_screens/text_box_quest.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/feedback_screens/questions_screens/radio_btn_quest.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../../models/feedback_answer_model.dart';

class FeedbackController extends GetxController {
  bool isLoading = true;
  String? value1, value2, value3, value4, value5;
  List<dynamic> questionList = [];

  late FeedbackData? feedbackData;

  List<FeedbackQuestionsModel> feedbackQuestionsList = [];

  List<Widget> feedbackQuestWidgetList = [];
  final TextEditingController descController = TextEditingController();
  bool? isConnected = false;

  @override
  void onInit() {
    super.onInit();
    // calling get feedback method
    _checkConnectivity();
  }

  _checkConnectivity() async {
    if (!await checkConnectivity()) {
      // calling show custom dialog box method

      // showCustomDialogBox(
      //     context: Get.context!,
      //     title: kInfo,
      //     description: kInternetNotAvailable);

      // update([kFeedback]);
    } else {
      isConnected = true;
      await showProgressDialog(Get.context!,
          message: kMsgPleaseWaitFetchingData);
      update([kFeedback]);

      getFeedbackQuestions();
      isLoading = false; // calling hide progress dialog method
      await hideProgressDialog();
      update([kFeedback]);
    }
  }

  getFeedbackQuestions() async {
    isLoading = true;
    update([kFeedback]);
    // if (!await checkConnectivity()) {
    //   Get.back();
    // }
    feedbackQuestionsList =
        await GailConnectServices.to.getFeedbackQuestionsApi();

    for (int i = 0; i < feedbackQuestionsList.length; i++) {
      questionList.add(feedbackQuestionsList[i].questions.toString());
    }
    // print(answersList);

    isLoading = false;

    update([kFeedback]);
  }

  @override
  void dispose() {
    descController.dispose();

    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kFeedbackScreen, activityScreen: "/feedback");
  }

  changeValue() async {
    update([kFeedback]);
  }

  getFeedback() async {
    isLoading = true;
    update([kFeedback]);

    // calling get feedback api method
    feedbackData = await GailConnectServices.to.getFeedbackApi();

    isLoading = false;
    update([kFeedback]);

    if (feedbackData != null && feedbackData!.statusCode != 200) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!,
          title: kInfo,
          description: feedbackData!.message);
    } else if (feedbackData!.feedbackList.isNotEmpty) {
      // calling generated quest answer widgets method
      _generateQuestAnswerWidgets();
    }
  }

  _generateQuestAnswerWidgets() {
    final List<Widget> _tempWidgetList = [];

    for (final MFeedback _feedback in feedbackData!.feedbackList) {
      switch (_feedback.questionType!.toLowerCase()) {
        case kRadioQuestType:
          _tempWidgetList.add(RadioBtnQuest(feedback: _feedback));

          break;

        case kDropdownQuestType:
          _tempWidgetList.add(DropdownQuest(feedback: _feedback));

          break;

        case kTextQuestType:
          _tempWidgetList.add(TextBoxQuest(feedback: _feedback));

          break;
      }
    }

    feedbackQuestWidgetList = _tempWidgetList;
    update([kFeedback]);
  }

  submitFeedback(FeedbackAnswer queAnsList) async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    // Map<String, String> object;
    // if (value1 == null ||
    //     value2 == null ||
    //     value3 == null ||
    //     value4 == null ||
    //     value5 == null) {
    //   await showCustomDialogBox(
    //       context: Get.context!,
    //       title: kError,
    //       description: "Kindly fill the all the values.");
    // } else {
    String? version;
    if (Platform.isIOS) {
      version = pref.getString("iosVersion",isEncrypted: true).toString();
    }
    if (Platform.isAndroid) {
      version = pref.getString("apkVersion",isEncrypted: true).toString();
    }
    var _response;
    if (descController.text.isNotEmpty) {
      value5 = descController.text.toString();
    }
    // if (value5!.toLowerCase().contains("no")) {
    _response = await GailConnectServices.to.sendFeedback(
      queAnsList, value5!,
      // answersList,
    ); //object, value5!,
    // }
    // if (value5!.toLowerCase().contains("yes")) {
    //   _response = await GailConnectServices.to.sendFeedback(
    //       value1!, value2!, value3!, value4!, descController.text.toString());
    // }

    if (_response != null) {
      if (_response.statusCode == 200) {
        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!,
            title: kSuccess,
            description:
                _response.body["Message"] + " for GAIL CONNECT " + version);

        Get.back();
      } else {
        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!,
            title: kError,
            description: _response.body["Message"]);
      }
    }
    // }
  }

  onFeedbackSubmitted() async {
    final List<Map<String, String>> _jsonList = [];
    String _userId = '', _surveyId = '', _answerText = '', _questionId = '';
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    final String _cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    for (final MFeedback _feedback in feedbackData!.feedbackList) {
      _answerText = '';
      _surveyId = _feedback.surveyId!;
      _userId =_cpfNumber;
      _questionId = _feedback.questionId!;

      if (_feedback.ansText.isNotEmpty) {
        _answerText = _feedback.ansText;
      }

      for (final QuestOption _questOption in _feedback.questOptionList) {
        if (_questOption.isAnsSelected) {
          _answerText = _questOption.value!;
        }
      }

      final Map<String, String> _body = {
        kJsonUserIdCaps: _userId,
        kJsonSurveyIdCaps: _surveyId,
        kJsonQuestionIdCaps: _questionId,
        kJsonAnswerTextCaps: _answerText,
      };

      _jsonList.add(_body);
    }

    // calling show progress dialog method
    await showProgressDialog(Get.context!);

    // calling submit survey api method
    final _response =
        await GailConnectServices.to.submitSurveyApi(body: _jsonList);

    // calling hide progress dialog method
    await hideProgressDialog();

    if (_response != null) {
      if (_response.statusCode == 200) {
        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!,
            title: kSuccess,
            description: _response.body[kJsonMessage]);

        Get.back();
      } else {
        // calling show custom dialog box method
        await showCustomDialogBox(
            context: Get.context!,
            title: kError,
            description: _response.body[kJsonMessage]);
      }
    }
  }
}
