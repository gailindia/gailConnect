// Created By Amit Jangid 22/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:gail_connect/ui/widgets/table_widget.dart';
import 'package:gail_connect/ui/widgets/no_files_found.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/dash_controllers/e_note_sheet_controllers/e_note_sheet_search_controller.dart';

import '../../../styles/color_controller.dart';

class ENoteSheetSearchScreen extends StatelessWidget {
  const ENoteSheetSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      body: GetBuilder<ENoteSheetSearchController>(
        id: kENoteSheetSearch,
        init: ENoteSheetSearchController(),
        builder: (_eNoteSheetSearchController) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: MaterialCard(
                    borderRadius: 12,
                    padding: const EdgeInsets.only(),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            controller:
                                _eNoteSheetSearchController.searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: kEnterENoteSheetNo,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_eNoteSheetSearchController
                            .searchController.value.text.isNotEmpty) ...[
                          IconButton(
                            color: colorController.kBlackShadeColor,
                            icon: const Icon(MaterialIcons.clear),
                            // calling clear search text method
                            onPressed: () =>
                                _eNoteSheetSearchController.clearSearchText(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                MaterialCard(
                  borderRadius: 12,
                  margin: const EdgeInsets.only(top: 12, right: 12),
                  // calling get fms detail list method
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    // calling get e note sheet search list method
                    _eNoteSheetSearchController.getENoteSheetSearchList();
                  },
                  child: Icon(Feather.search,
                      color: colorController.kPrimaryDarkColor),
                ),
              ],
            ),
            if (_eNoteSheetSearchController.isLoading) ...[
              const Expanded(
                  child: SingleChildScrollView(child: LoadingWidget())),
            ] else if (_eNoteSheetSearchController
                .eNoteSheetSearchList.isNotEmpty) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: colorController.kPrimaryLightColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5)),
                          child: Row(
                            children: const [
                              TableTitle(flex: 1, title: kSNo),
                              TableTitle(title: kENoteSheetNo),
                              TableTitle(title: kInitiator),
                              TableTitle(
                                  title: kFileDate, showRightBorder: false),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 48),
                          itemCount: _eNoteSheetSearchController
                              .eNoteSheetSearchList.length,
                          itemBuilder: (context, _position) {
                            final ENoteSheetDetails _eNoteSheetDetails =
                                _eNoteSheetSearchController
                                    .eNoteSheetSearchList[_position];

                            return InkWell(
                              onTap: () => Get.toNamed(
                                kENoteSheetFullDetailsRoute,
                                arguments: {
                                  kTitle: kENoteSheetSearchDetails,
                                  kFileId: _eNoteSheetDetails.fileId
                                },
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(),
                                      right: BorderSide(),
                                      bottom: BorderSide()),
                                ),
                                child: Row(
                                  children: [
                                    TableContent(
                                        flex: 1,
                                        description: '${_position + 1}'),
                                    TableContent(
                                        showLink: true,
                                        description:
                                            _eNoteSheetDetails.fileNo!),
                                    TableContent(
                                        description:
                                            _eNoteSheetDetails.initiator!),
                                    TableContent(
                                        showRightBorder: false,
                                        description:
                                            _eNoteSheetDetails.fileDate!),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              verticalSpace24,
              const Expanded(child: NoFilesFound()),
              verticalSpace24,
            ],
          ],
        ),
      ),
    );
  }
}
