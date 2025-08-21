// Created By Amit Jangid on 25/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/bis_helpdesk_calls_controllers/bis_helpdesk_calls_controller.dart';
import 'package:gail_connect/models/bis_helpdesk_calls.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';

import '../../../styles/color_controller.dart';

class BISHelpdeskClosedCallsScreen extends StatelessWidget {
  const BISHelpdeskClosedCallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: kBISHelpdesk),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: colorController.kPrimaryDarkColor,
      //   onPressed: () => Get.toNamed(kBISHelpdeskAddCallRoute),
      //   child: const Icon(Icons.add, size: 30),
      // ),
      body: GetBuilder<BISHelpdeskCallsController>(
        id: kBISHelpdeskCalls,
        init: BISHelpdeskCallsController(),
        builder: (_controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialCard(
                borderRadius: 12,
                margin: const EdgeInsets.only(top: 6, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      autocorrect: false,
                      controller: _controller.searchController,
                      keyboardType: TextInputType.visiblePassword,
                      // calling on user calls search method
                      onChanged: _controller.onUserCallsSearch,
                      decoration: InputDecoration(
                        hintText: kEnterCallIdDescription,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          color: colorController.kBlackShadeColor,
                          icon: const Icon(Icons.clear, color: Colors.black54),
                          onPressed: () {
                            _controller.searchController.text = '';

                            // calling on user calls search method
                            _controller.onUserCallsSearch('');
                          },
                        ),
                      ),
                    ),
                    // verticalSpace12,
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                           Expanded(
                              child: Text(kStatus, style: textStyle14Bold)),
                          horizontalSpace12,
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField<String>(
                              value: _controller.selectedCallStatus,
                              // calling on user call status selected method
                              onChanged: _controller.onUserCallStatusSelected,
                              hint: Text(kStatus,
                                  style: textStyle14Normal.copyWith(
                                      color: Colors.grey)),
                              items: const [kOpen, kAll, kClose]
                                  .map<DropdownMenuItem<String>>(
                                      (String _value) =>
                                          DropdownMenuItem<String>(
                                              value: _value,
                                              child: Text(_value,
                                                  style: textStyle14Normal)))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_controller.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_controller.filteredUserCallsList.isEmpty) ...[
                const Expanded(child: NoRecordsFound()),
              ] else ...[
                verticalSpace12,
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.filteredUserCallsList.length,
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                    itemBuilder: (context, _position) {
                      final BISHelpdeskCalls _bisHelpdeskCalls =
                          _controller.filteredUserCallsList[_position];

                      final Color _callIdColor =
                          (_bisHelpdeskCalls.status!.toString().toLowerCase() ==
                                  kOpen.toLowerCase())
                              ? colorController.kPrimaryColor
                              : Colors.green;

                      return _bisHelpdeskCalls.status!
                                  .toString()
                                  .toLowerCase() ==
                              kClose.toLowerCase()
                          ? MaterialCard(
                              borderRadius: 12,
                              shadowColor: Colors.black38,
                              padding: const EdgeInsets.only(),
                              margin: const EdgeInsets.only(bottom: 12),
                              onTap: () => _controller.onUserCallSelected(
                                  userCall: _bisHelpdeskCalls),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: RichTextWidget(
                                      caption: kCallId,
                                      textAlign: TextAlign.center,
                                      description: _bisHelpdeskCalls.callId!,
                                      captionStyle: textStyle18Bold.copyWith(
                                          color: _callIdColor),
                                      descriptionStyle: textStyle18Bold
                                          .copyWith(color: _callIdColor),
                                    ),
                                  ),
                                  const Divider(height: 1, color: Colors.black),
                                  verticalSpace6,
                                  HeadingRowItem(
                                    maxLines: 2,
                                    caption: kDescription,
                                    desc: _bisHelpdeskCalls.desc!,
                                    icon: "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  HeadingRowItem(
                                    caption: kStatus,
                                    desc: _bisHelpdeskCalls.status!,
                                    icon: "",
                                  ),
                                  verticalSpace12,
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
