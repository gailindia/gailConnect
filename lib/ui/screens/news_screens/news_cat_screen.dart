// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gail_connect/models/news_category.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/no_internet.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/news_controllers/news_controller.dart';
import 'package:gail_connect/core/controllers/news_controllers/news_cat_controller.dart';

import '../../styles/color_controller.dart';

class NewsCatScreen extends StatelessWidget {
  const NewsCatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<NewsCatController>(
      id: kNewsCategory,
      init: NewsCatController(),
      builder: (_newsCatController) => Scaffold(
        backgroundColor: colorController.kBgPopupColor,
        appBar: CustomAppBar(title: NewsController.to.newsListTitle),
        body: Column(
          children: [
            if (_newsCatController.isConnected) ...[
              if (_newsCatController.isLoading) ...[
                const LoadingWidget(),
              ] else if (_newsCatController.newsCategoryList.isEmpty) ...[
                const Expanded(child: NoRecordsFound()),
              ] else if (_newsCatController.newsCategoryList.isNotEmpty) ...[
                /*Expanded(
                  child: GestureDetector(
                    // calling open news method
                    onTap: () => _newsCatController.openNews(newsLink: _newsCatController.selectedNewsCategory.body),
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 120,
                      clipBehavior: Clip.antiAlias,
                      physics: const FixedExtentScrollPhysics(),
                      controller: _newsCatController.fixedExtentScrollController,
                      onSelectedItemChanged: (_position) {
                        _newsCatController.selectedNewsCategory = _newsCatController.newsCategoryList[_position];
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _newsCatController.newsCategoryList.length,
                        builder: (context, _position) {
                          final NewsCategory _newsCategory = _newsCatController.newsCategoryList[_position];
                          final _eventDateArr = _newsCategory.eventDate.split(' ');

                          return MaterialCard(
                            borderRadius: 12,
                            padding: const EdgeInsets.only(),
                            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    debugPrint('tapped items index is: $_position');
                                    _newsCatController.openNews(newsLink: _newsCategory.body);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: kPrimaryDarkColor),
                                    child: Center(
                                      child:
                                          Text(_eventDateArr[0], style: textStyle30Bold.copyWith(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                horizontalSpace6,
                                Text(
                                  _eventDateArr[1],
                                  style: textStyle18Bold,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),*/
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.18,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.vertical,
                    ),
                    items: _newsCatController.newsCategoryList.map(
                      (NewsCategory _newsCategory) {
                        final _eventDateArr =
                            _newsCategory.eventDate.split(' ');

                        return MaterialCard(
                          borderRadius: 12,
                          padding: const EdgeInsets.only(),
                          margin: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          // calling open news method
                          onTap: () => _newsCatController.openNews(
                              newsLink: _newsCategory.body),
                          child: LayoutBuilder(
                            builder: (context, constraint) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorController.kPrimaryDarkColor),
                                  child: Center(
                                    child: Text(_eventDateArr[0],
                                        style: textStyle30Bold.copyWith(
                                            color: Colors.white)),
                                  ),
                                ),
                                horizontalSpace6,
                                if (constraint.minWidth > 20 ||
                                    constraint.maxWidth > 20) ...[
                                  Text(
                                    _eventDateArr[1],
                                    style: textStyle18Bold,
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ] else ...[
              const Expanded(child: NoInternet()),
            ],
          ],
        ),
      ),
    );
  }
}
