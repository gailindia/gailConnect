// Created By Amit Jangid on 24/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/primary_icon_button.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/bis_helpdesk_calls_controllers/bis_helpdesk_add_call_controller.dart';

class BISHelpdeskAddCallScreen extends StatelessWidget {
  const BISHelpdeskAddCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorController colorController= Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        appBar:  CustomAppBar(title: kBISHelpdeskNewCall),
        body: GetBuilder<BISHelpdeskAddCallController>(
          id: kBISHelpdeskNewCall,
          init: BISHelpdeskAddCallController(),
          builder: (_controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 18, left: 12, right: 12, bottom: 48),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text('$kUsername:', style: textStyle18Bold),
                        horizontalSpace6,
                        Expanded(
                            child: Text(
                                MainDashController
                                    .to.loggedInEmployee!.empName!,
                                style: textStyle18Bold)),
                      ],
                    ),
                    verticalSpace18,
                    Row(
                      children: [
                         Expanded(
                            child: Text(kProposedAreaOfCall,
                                style: textStyle14Bold)),
                        horizontalSpace6,
                        Expanded(
                          flex: 3,
                          child: DropdownSearch<Areas>(
                            // maxHeight: 500,
                            // showSearchBox: true,
                            // showClearButton: true,
                            // mode: Mode.BOTTOM_SHEET,
                            // showAsSuffixIcons: true,
                            items: _controller.areasList,
                            // label: kSelectProposedAreaOfCall,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: kSelectProposedAreaOfCall,
                                hintText: kSelectProposedAreaOfCall,
                              ),
                            ),
                            // dropdownSearchBaseStyle: textStyle13Normal,
                            itemAsString: (Areas? _area) => _area!.areaName,
                            // calling on area selected method
                            onChanged: (Areas? _area) =>
                                _controller.onAreaSelected(area: _area),
                            // emptyBuilder: (context, _searchString) =>
                            //     const Scaffold(body: NoRecordsFound()),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace12,
                    Row(
                      children: [
                         Expanded(
                            child: Text(kProposedTypeOfCall,
                                style: textStyle14Bold)),
                        horizontalSpace6,
                        Expanded(
                          flex: 3,
                          child: DropdownSearch<Types>(
                            // maxHeight: 500,
                            // showSearchBox: true,
                            // showClearButton: true,
                            // mode: Mode.BOTTOM_SHEET,
                            // showAsSuffixIcons: true,
                            items: _controller.typesList,
                            // hint: kSelectProposedTypeOfCall,
                            dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: kSelectProposedTypeOfCall,
                                hintText: kSelectProposedTypeOfCall,
                              ),
                            ),
                            // dropdownSearchBaseStyle: textStyle13Normal,
                            itemAsString: (Types? _type) => _type!.typeName,
                            // calling on types selected method
                            onChanged: (Types? _types) =>
                                _controller.onTypesSelected(_types),
                            // emptyBuilder: (context, _searchString) =>
                            //     const Scaffold(body: NoRecordsFound()),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace12,
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      controller: _controller.descController,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (_desc) =>
                          _desc!.isEmpty ? kMsgDescriptionIsRequired : null,
                      decoration: const InputDecoration(
                          labelText: kDescription,
                          contentPadding: EdgeInsets.all(12)),
                    ),
                    verticalSpace18,
                    if (_controller.capturedImage != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(_controller.capturedImage!.name,
                            style: textStyle14Normal),
                      ),
                    ] else if (_controller.selectedFilesList.isNotEmpty) ...[
                       Text('$kSelectedFiles:', style: textStyle14Bold),
                      verticalSpace6,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _controller.selectedFilesList
                            .map(
                              (PlatformFile _file) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child:
                                    Text(_file.name, style: textStyle14Normal),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                     Text(kFileUpload, style: textStyle14Bold),
                    verticalSpace12,
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryIconButton(
                            text: kCapture,
                            icon: Icons.camera,
                            margin: const EdgeInsets.only(),
                            // calling capture image method
                            onPressed: () => _controller.checkPermission(),
                            btnTextStyle:
                                buttonTextStyle.copyWith(color: Colors.black),
                          ),
                        ),
                        horizontalSpace12,
                        Expanded(
                          child: PrimaryIconButton(
                            text: kChooseFile,
                            icon: Icons.attachment_outlined,
                            margin: const EdgeInsets.only(),
                            // calling choose files method
                            onPressed: () => _controller.chooseFiles(),
                            btnTextStyle:
                                buttonTextStyle.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace6,
                    PrimaryButton(
                      text: kAddCall,
                      onPressed: () {
                        if (_controller.formKey.currentState!.validate()) {
                          _controller.formKey.currentState!.save();

                          // calling add new call method
                          _controller.addNewCall();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
