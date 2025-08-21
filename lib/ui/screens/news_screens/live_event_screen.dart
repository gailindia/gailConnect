// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/models/live_event.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/core/controllers/news_controllers/live_event_controller.dart';

class LiveEventScreen extends StatelessWidget {
  const LiveEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: kLiveEvents),
      body: GetBuilder<LiveEventController>(
        id: kLiveEvents,
        init: LiveEventController(),
        builder: (_liveEventController) {
          if (_liveEventController.isLoading) {
            return const LoadingWidget();
          } else if (_liveEventController.liveEventList.isEmpty) {
            return const NoRecordsFound();
          } else {
            return ListView.builder(
              itemCount: _liveEventController.liveEventList.length,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
              itemBuilder: (context, _position) {
                final LiveEvent _liveEvent = _liveEventController.liveEventList[_position];

                return MaterialCard(
                  borderRadius: 12,
                  // calling open live event link method
                  onTap: () => _liveEventController.openLiveEventLink(
                    context: context,
                    link: _liveEvent.navigationLink!,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InitialTextContainer(text: _liveEvent.title!),
                      horizontalSpace12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_liveEvent.title!, style: textStyle18Bold),
                            const SizedBox(height: 3),
                            Text(_liveEvent.description!, style: textStyle16Normal),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
