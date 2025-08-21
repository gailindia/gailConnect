// Created By Amit Jangid 07/09/21

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/models/feedback_answer_model.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:multiutillib/animations/fade_animation.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/feedback_controller.dart';
import 'package:multiutillib/widgets/material_card.dart';

import '../../../styles/color_controller.dart';
import '../../../widgets/no_internet.dart';
import '../../../widgets/show_custom_dialog_box.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar: CustomAppBar(title: kFeedback),
        body: GetBuilder<FeedbackController>(
            id: kFeedback,
            init: FeedbackController(),
            builder: (_feedbackController) {
              final List<QueAnss> queans = [];
              final FeedbackAnswer queAnsList = FeedbackAnswer(queAnss: queans);

              // List<MyDataModel> dataList = parseJson(abc);
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 36),
                  // padding:
                  //     const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                  child: _feedbackController.isConnected!
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FadeAnimation(
                              delay: 0.7,
                              child: MaterialCard(
                                borderRadius: 12,
                                child: Text(
                                  "👋  Help us improve",
                                  textAlign: TextAlign.center,
                                  style: textStyle20Bold.copyWith(
                                      color: colorController.kPrimaryDarkColor),
                                ),
                              ),
                            ),
                            FadeAnimation(
                                delay: 0.7,
                                child: MaterialCard(
                                  borderRadius: 12,
                                  // margin: const EdgeInsets.only(
                                  //     top: 8, left: 12, right: 12, bottom: 36),
                                  // padding: const EdgeInsets.only(
                                  //     left: 12, right: 12, bottom: 36),
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        // scrollDirection: Axis.vertical,
                                        itemCount: _feedbackController
                                            .feedbackQuestionsList.length,
                                        itemBuilder: (context, index) {
                                          List<String> shownList = [];
                                          final tagName = _feedbackController
                                              .feedbackQuestionsList[index]
                                              .answer
                                              .toString();
                                          final split = tagName.split(',');
                                          final Map<int, String> values = {
                                            for (int i = 0;
                                                i < split.length;
                                                i++)
                                              i: split[i]
                                          };
                                          for (int i = 0;
                                              i < values.length;
                                              i++) {
                                            shownList.add(values[i].toString());
                                          }
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              verticalSpace30,
                                              Text(
                                                _feedbackController
                                                    .feedbackQuestionsList[
                                                        index]
                                                    .questions
                                                    .toString(),
                                                style: textStyle16Bold.copyWith(
                                                    color: colorController
                                                        .kPrimaryDarkColor),
                                              ),
                                              verticalSpace3,
                                              CustomRadioButton(
                                                elevation: 3,
                                                scrollController:
                                                    ScrollController(),
                                                autoWidth: true,
                                                padding: 1,
                                                absoluteZeroSpacing: false,
                                                horizontal: //true,
                                                    tagName.length > 50
                                                        ? true
                                                        : false,
                                                unSelectedColor:
                                                    Theme.of(context)
                                                        .canvasColor,
                                                enableShape: true,
                                                buttonLables: shownList,
                                                buttonValues: shownList,
                                                buttonTextStyle:
                                                    const ButtonTextStyle(
                                                        selectedColor:
                                                            Colors.white,
                                                        unSelectedColor:
                                                            Colors.black,
                                                        textStyle: TextStyle(
                                                            fontSize: 12)),
                                                radioButtonValue: (value) {
                                                  if (queans.isNotEmpty) {
                                                    if (queans
                                                        .asMap()
                                                        .keys
                                                        .contains(index)) {
                                                      queans.removeWhere(
                                                          (element) =>
                                                              element.position
                                                                  .toString() ==
                                                              index.toString());
                                                      queans.add(
                                                        QueAnss(
                                                          que: _feedbackController
                                                              .feedbackQuestionsList[
                                                                  index]
                                                              .questions
                                                              .toString(),
                                                          ans: value.toString(),
                                                          position:
                                                              index.toString(),
                                                        ),
                                                      );
                                                    } else {
                                                      queans.add(
                                                        QueAnss(
                                                          que: _feedbackController
                                                              .feedbackQuestionsList[
                                                                  index]
                                                              .questions
                                                              .toString(),
                                                          ans: value.toString(),
                                                          position:
                                                              index.toString(),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    queans.add(
                                                      QueAnss(
                                                          que: _feedbackController
                                                              .feedbackQuestionsList[
                                                                  index]
                                                              .questions
                                                              .toString(),
                                                          ans: value.toString(),
                                                          position:
                                                              index.toString()),
                                                    );
                                                  }

                                                  // print(queans.length);
                                                  print(queAnsList.toJson());
                                                  // FeedbackAnswer(
                                                  //     ansList: ansList);
                                                },
                                                ///TODO : accentcolor
                                                selectedColor: Theme.of(context)
                                                    .hintColor,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Text(
                                        "Kindly provide some valuable suggestions",
                                        style: textStyle16Bold.copyWith(
                                            color: colorController
                                                .kPrimaryDarkColor),
                                      ),
                                      verticalSpace12,
                                      TextFormField(
                                        minLines: 3,
                                        maxLines: 5,
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        controller:
                                            _feedbackController.descController,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        validator: (_desc) => _desc!.isEmpty
                                            ? kMsgDescriptionIsRequired
                                            : null,
                                        decoration: const InputDecoration(
                                          labelText: "Suggestions",
                                          contentPadding: EdgeInsets.all(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            PrimaryButton(
                                text: kSubmit,
                                onPressed: () async {
                                  print(queans.length);
                                  if (queans.length == 3 &&
                                      _feedbackController
                                          .descController.text.isNotEmpty) {
                                    _feedbackController
                                        .submitFeedback(queAnsList);
                                  } else {
                                    await showCustomDialogBox(
                                        context: Get.context!,
                                        title: kError,
                                        description:
                                            "Kindly complete the form.");
                                  }
                                }),
                          ],
                        )
                      :  NoInternet(),
                ),
              );
              // ListView.builder(
              // shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              // itemCount: _feedbackController
              //     .feedbackQuestionsList.length,
              //               itemBuilder: (context, index) {
              // Text("data");
              //               },
              // return SingleChildScrollView(
              //   padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              // FadeAnimation(
              //   delay: 0.7,
              //   child: MaterialCard(
              //     borderRadius: 12,
              //     child: Text(
              //       "👋  Help us improve",
              //       textAlign: TextAlign.center,
              //       style: textStyle20Bold.copyWith(
              //           color: kPrimaryDarkColor),
              //     ),
              //   ),
              // ),
              //       FadeAnimation(
              //         delay: 0.7,
              //         child: MaterialCard(
              //           borderRadius: 12,
              //           child: ListView.builder(
              //               shrinkWrap: true,
              //               scrollDirection: Axis.horizontal,
              //               itemCount: _feedbackController
              //                   .feedbackQuestionsList.length,
              //               itemBuilder: (context, index) {
              //                 return ListTile(
              //                     leading: const Icon(Icons.restore),
              // title: Text(_feedbackController
              //     .feedbackQuestionsList[index].questions
              //     .toString()));
              //                 // Column(
              //                 //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 //                 children: [
              //                 //                   verticalSpace6,
              //                 //                   Text(
              //                 //                     "1. How would you rate the overall user interface of the app?",
              //                 //                     textAlign: TextAlign.start,
              //                 //                     style: textStyle14Bold.copyWith(
              //                 //                         color: kPrimaryDarkColor),
              //                 //                   ),
              //                 //                   verticalSpace6,
              // CustomRadioButton(
              //   elevation: 2,
              //   scrollController: ScrollController(),
              //   autoWidth: true,
              //   padding: 2,
              //   absoluteZeroSpacing: false,
              //   horizontal: false,
              //   unSelectedColor: Theme.of(context).canvasColor,
              //   enableShape: true,
              //   buttonLables: [
              //     'Excellent',
              //     'Good',
              //     'Average',
              //     'Needs improvement',
              //   ],
              //   buttonValues: [
              //     'Excellent',
              //     'Good',
              //     'Average',
              //     'Needs improvement',
              //   ],
              //   buttonTextStyle: ButtonTextStyle(
              //       selectedColor: Colors.white,
              //       unSelectedColor: Colors.black,
              //       textStyle: TextStyle(fontSize: 12)),
              //   radioButtonValue: (value1) {
              //     _feedbackController.value1 = value1 as String?;
              //     print(_feedbackController.value1);
              //   },
              //   selectedColor: Theme.of(context).accentColor,
              // ),
              //                 //                   verticalSpace24,
              //                 //                   Text(
              //                 //                     "2. How easy was it to navigate the app?",
              //                 //                     textAlign: TextAlign.start,
              //                 //                     style: textStyle14Bold.copyWith(
              //                 //                         color: kPrimaryDarkColor),
              //                 //                   ),
              //                 //                   verticalSpace6,
              //                 //                   CustomRadioButton(
              //                 //                     scrollController: ScrollController(),
              //                 //                     elevation: 2,
              //                 //                     autoWidth: true,
              //                 //                     absoluteZeroSpacing: false,
              //                 //                     horizontal: false,
              //                 //                     unSelectedColor: Theme.of(context).canvasColor,
              //                 //                     enableShape: true,
              //                 //                     padding: 2,
              //                 //                     buttonLables: [
              //                 //                       'Excellent',
              //                 //                       'Good',
              //                 //                       'Average',
              //                 //                       'Needs improvement',
              //                 //                     ],
              //                 //                     buttonValues: [
              //                 //                       'Excellent',
              //                 //                       'Good',
              //                 //                       'Average',
              //                 //                       'Needs improvement',
              //                 //                     ],
              //                 //                     buttonTextStyle: ButtonTextStyle(
              //                 //                         selectedColor: Colors.white,
              //                 //                         unSelectedColor: Colors.black,
              //                 //                         textStyle: TextStyle(fontSize: 12)),
              //                 //                     radioButtonValue: (value2) {
              //                 //                       _feedbackController.value2 = value2 as String?;
              //                 //                       print(_feedbackController.value2);
              //                 //                     },
              //                 //                     selectedColor: Theme.of(context).accentColor,
              //                 //                   ),
              //                 //                   verticalSpace24,
              //                 //                   Text(
              //                 //                     "3. Did the app meet your expectations?",
              //                 //                     textAlign: TextAlign.start,
              //                 //                     style: textStyle14Bold.copyWith(
              //                 //                         color: kPrimaryDarkColor),
              //                 //                   ),
              //                 //                   CustomRadioButton(
              //                 //                     scrollController: ScrollController(),
              //                 //                     elevation: 8,
              //                 //                     autoWidth: false,
              //                 //                     absoluteZeroSpacing: false,
              //                 //                     horizontal: true,
              //                 //                     unSelectedColor: Theme.of(context).canvasColor,
              //                 //                     enableShape: true,
              //                 //                     padding: 2,
              //                 //                     buttonLables: [
              //                 //                       'Exceeded expectations',
              //                 //                       'Met expectations',
              //                 //                       'Somewhat met expectations',
              //                 //                       'I had no expectations',
              //                 //                     ],
              //                 //                     buttonValues: [
              //                 //                       'Exceeded expectations',
              //                 //                       'Met expectations',
              //                 //                       'Somewhat met expectations',
              //                 //                       'I had no expectations',
              //                 //                     ],
              //                 //                     buttonTextStyle: ButtonTextStyle(
              //                 //                         selectedColor: Colors.white,
              //                 //                         unSelectedColor: Colors.black,
              //                 //                         textStyle: TextStyle(fontSize: 12)),
              //                 //                     radioButtonValue: (value3) {
              //                 //                       _feedbackController.value3 = value3 as String?;
              //                 //                       print(_feedbackController.value3);
              //                 //                     },
              //                 //                     selectedColor: Theme.of(context).accentColor,
              //                 //                   ),
              //                 //                   Text(
              //                 //                     "4. How would you rate the performance of the app (speed, reliability, etc.)?",
              //                 //                     textAlign: TextAlign.start,
              //                 //                     style: textStyle14Bold.copyWith(
              //                 //                         color: kPrimaryDarkColor),
              //                 //                   ),
              //                 //                   verticalSpace6,
              //                 //                   CustomRadioButton(
              //                 //                     scrollController: ScrollController(),
              //                 //                     elevation: 2,
              //                 //                     autoWidth: true,
              //                 //                     absoluteZeroSpacing: false,
              //                 //                     horizontal: false,
              //                 //                     unSelectedColor: Theme.of(context).canvasColor,
              //                 //                     enableShape: true,
              //                 //                     padding: 2,
              //                 //                     buttonLables: const [
              //                 //                       'Excellent',
              //                 //                       'Good',
              //                 //                       'Average',
              //                 //                       'Needs improvement',
              //                 //                     ],
              //                 //                     buttonValues: const [
              //                 //                       'Excellent',
              //                 //                       'Good',
              //                 //                       'Average',
              //                 //                       'Needs improvement',
              //                 //                     ],
              //                 //                     buttonTextStyle: const ButtonTextStyle(
              //                 //                         selectedColor: Colors.white,
              //                 //                         unSelectedColor: Colors.black,
              //                 //                         textStyle: TextStyle(fontSize: 12)),
              //                 //                     radioButtonValue: (value4) {
              //                 //                       _feedbackController.value4 = value4 as String?;
              //                 //                       _feedbackController.changeValue();

              //                 //                       print(_feedbackController.value4);
              //                 //                     },
              //                 //                     selectedColor: Theme.of(context).accentColor,
              //                 //                   ),
              //                 //                   verticalSpace18,
              //                 //                   Text(
              //                 //                     "5. Were there any features or functionality missing from the app that you would have liked to see?",
              //                 //                     textAlign: TextAlign.start,
              //                 //                     style: textStyle14Bold.copyWith(
              //                 //                         color: kPrimaryDarkColor),
              //                 //                   ),
              //                 //                   verticalSpace6,
              //                 //                   CustomRadioButton(
              //                 //                     scrollController: ScrollController(),
              //                 //                     elevation: 2,
              //                 //                     autoWidth: true,
              //                 //                     absoluteZeroSpacing: false,
              //                 //                     horizontal: false,
              //                 //                     unSelectedColor: Theme.of(context).canvasColor,
              //                 //                     enableShape: true,
              //                 //                     padding: 2,
              //                 //                     buttonLables: [
              //                 //                       'Yes',
              //                 //                       'No',
              //                 //                     ],
              //                 //                     buttonValues: [
              //                 //                       'Yes',
              //                 //                       'No',
              //                 //                     ],
              //                 //                     buttonTextStyle: ButtonTextStyle(
              //                 //                         selectedColor: Colors.white,
              //                 //                         unSelectedColor: Colors.black,
              //                 //                         textStyle: TextStyle(fontSize: 12)),
              // radioButtonValue: (value5) {
              //   _feedbackController.value5 = value5 as String?;
              //   _feedbackController.changeValue();
              //   print(_feedbackController.value5);
              // },
              //                 //                     selectedColor: Theme.of(context).accentColor,
              //                 //                   ),
              //                 //                   verticalSpace18,
              //                 //                   Visibility(
              //                 //                     visible: _feedbackController.value5
              //                 //                         .toString()
              //                 //                         .isCaseInsensitiveContains("yes"),
              // child: TextFormField(
              //   minLines: 3,
              //   maxLines: 5,
              //   autocorrect: false,
              //   keyboardType: TextInputType.text,
              //   controller: _feedbackController.descController,
              //   textCapitalization:
              //       TextCapitalization.sentences,
              //   validator: (_desc) => _desc!.isEmpty
              //       ? kMsgDescriptionIsRequired
              //       : null,
              //   decoration: const InputDecoration(
              //       labelText:
              //           "Kindly provide some suggestions",
              //       contentPadding: EdgeInsets.all(12)),
              // ),
              //                 //                   )
              //                 //                   // _feedbackController.value5
              //                 //                   //         .toString()
              //                 //                   //         .contains("Yes")
              //                 //                   //     ? Container(
              //                 //                   //         height: 30, width: 30, color: Colors.amber)
              //                 //                   //     : Container(
              //                 //                   //         height: 30, width: 30, color: Colors.black)
              //                 //                 ],
              //                 //               ),
              //               }),
              //         ),
              //       ),
              //       // Column(
              //       //   crossAxisAlignment: CrossAxisAlignment.start,
              //       //   children: _feedbackController.feedbackQuestWidgetList
              //       //       .map((Widget _child) => FadeAnimation(delay: 1.2, child: _child))
              //       //       .toList(),
              //       // ),
              //       // calling on feedback submitted method
              //       // PrimaryButton(text: kSubmit, onPressed: () => {}),
              //       PrimaryButton(
              //           text: kSubmit,
              //           onPressed: () =>
              //               {_feedbackController.submitFeedback()}),
              //     ],
              //   ),
              // );
            })

        // body: GetBuilder<FeedbackController>(
        //   id: kFeedback,
        //   init: FeedbackController(),
        //   builder: (_feedbackController) {
        //     if (_feedbackController.isLoading) {
        //       return const LoadingWidget();
        //     } else if (_feedbackController.feedbackQuestWidgetList.isNotEmpty) {
        //       return SingleChildScrollView(
        //         padding: const EdgeInsets.only(left: 12, right: 12, bottom: 36),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.stretch,
        //           children: [
        //             FadeAnimation(
        //               delay: 0.7,
        //               child: MaterialCard(
        //                 borderRadius: 12,
        //                 child: Text(
        //                   _feedbackController
        //                       .feedbackData!.feedbackList[0].surveyTitle!,
        //                   textAlign: TextAlign.center,
        //                   style:
        //                       textStyle18Bold.copyWith(color: kPrimaryDarkColor),
        //                 ),
        //               ),
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: _feedbackController.feedbackQuestWidgetList
        //                   .map((Widget _child) =>
        //                       FadeAnimation(delay: 1.2, child: _child))
        //                   .toList(),
        //             ),
        //             // calling on feedback submitted method
        // PrimaryButton(
        //     text: kSubmit,
        //     onPressed: () =>
        //         _feedbackController.onFeedbackSubmitted()),
        //           ],
        //         ),
        //       );
        //     }

        //     return const NoRecordsFound();
        //   },
        // ),
        );
  }
}

class NoRecordsFound extends StatelessWidget {
  const NoRecordsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(kMsgNoRecordsFound, style: textStyle18Bold));
}
