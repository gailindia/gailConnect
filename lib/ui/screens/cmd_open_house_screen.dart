
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/cmd_open_controller.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib.dart';

class CMDOpenHouseScreen extends StatelessWidget {
  const CMDOpenHouseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ColorController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'CMD Open House', isBirthdayScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GetBuilder<CMDOpenHouseController>(
              id: kopenhouse,
              init: CMDOpenHouseController(),
              builder: (_controller) {
                return Form(
                  key: _controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          // showSearchBox: true,
                          // mode: Mode.BOTTOM_SHEET,
                          // showAsSuffixIcons: true,
                          items: _controller.arealist,
                          // label: kSelectarea,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: kSelectarea,
                              hintText: kSelectarea,
                            ),
                          ),
                          // dropdownSearchBaseStyle: textStyle13Normal,
                          // calling on area selected method
                          onChanged: (String? _dependant) => {
                            _controller.setDataArea(_dependant),
                          },
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          // emptyBuilder: (context, _searchString) =>
                          //     const Scaffold(body: NoRecordsFound()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          // showSearchBox: true,
                          // mode: Mode.BOTTOM_SHEET,
                          // showAsSuffixIcons: true,
                          items: _controller.directoratelist,
                          // label: kSelectdirectorate,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: kSelectdirectorate,
                              hintText: kSelectdirectorate,
                            ),
                          ),
                          // dropdownSearchBaseStyle: textStyle13Normal,
                          // calling on area selected method
                          onChanged: (String? _dependant) => {
                            _controller.setDataDirectorate(_dependant),
                          },
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          // emptyBuilder: (context, _searchString) =>
                          //     const Scaffold(body: NoRecordsFound()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 5,
                          maxLength: 200,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          controller: _controller.subjectController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (_desc) =>
                              _desc!.isEmpty ? kMsgSubjectIsRequired : null,
                          decoration: const InputDecoration(
                              labelText: kSubject,
                              contentPadding: EdgeInsets.all(12)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 5,
                          maxLength: 5000,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          controller: _controller.descriptionController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (_desc) =>
                              _desc!.isEmpty ? kMsgDescriptionIsRequired : null,
                          decoration: const InputDecoration(
                              labelText: kDescription,
                              contentPadding: EdgeInsets.all(12)),
                        ),
                      ),
                      verticalSpace12,
                      PrimaryButton(
                        text: kSubmit,
                        onPressed: () {
                          if (_controller.formKey.currentState!.validate()) {
                            _controller.formKey.currentState!.save();
                            _controller.submitopenHouse(context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
