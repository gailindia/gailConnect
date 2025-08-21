// Created By Amit Jangid on 20/12/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/create_emp_group_controller.dart';

import '../../../styles/color_controller.dart';

class CreateEmpGroupEnterNameScreen extends StatelessWidget {
  const CreateEmpGroupEnterNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController= Get.put(ColorController());
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: GetBuilder<CreateEmpGroupController>(
        id: kCreateGroup,
        builder: (_controller) {
          return Scaffold(
            appBar:  CustomAppBar(title: kNewGroupEnterGroupName),
            floatingActionButton: FloatingActionButton(
              tooltip: kNext,
              backgroundColor: colorController.kPrimaryDarkColor,
              child: const Icon(AntDesign.check, size: 30),
              // calling save group details method
              onPressed: () => _controller.createNewGroup(),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      // calling choose group icon method
                      onTap: () => _controller.chooseGroupIcon(),
                      child: Center(
                        child: Stack(
                          children: [
                            if (_controller.selectedGroupIconFile == null) ...[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: colorController.kPrimaryDarkColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                ),
                                child:  Icon(
                                    Icons.supervised_user_circle_sharp,
                                    size: 140,
                                    color: colorController.kDarkGreyColor),
                              ),
                            ] else ...[
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: colorController.kPrimaryDarkColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                  ),
                                  child: Image(
                                    width: 140,
                                    height: 140,
                                    image: FileImage(
                                        _controller.selectedGroupIconFile!),
                                  ),
                                ),
                              ),
                            ],
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.black38,
                                    shape: BoxShape.circle),
                                child: const Icon(AntDesign.edit),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace12,
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      controller: _controller.groupNameController,
                      validator: (_groupName) =>
                          _groupName!.isEmpty ? kMsgGroupNameIsRequired : null,
                      decoration: const InputDecoration(
                          labelText: kGroupName, hintText: kEnterGroupName),
                    ),
                    verticalSpace12,
                    Text(
                        '$kMembers: ${_controller.selectedEmployeesList.length}',
                        style: textStyle12Normal),
                    verticalSpace24,
                    MasonryGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding: const EdgeInsets.only(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.selectedEmployeesList.length,
                      // staggeredTileBuilder: (_position) => const StaggeredTile.fit(1),
                      itemBuilder: (context, _position) {
                        final Employee _employee =
                            _controller.selectedEmployeesList[_position];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularNetworkImageWidget(
                                imageUrl: _employee.image!),
                            Text(
                              _employee.empName!
                                  .replaceAll('  ', '\n')
                                  .replaceAll(' ', '\n'),
                              maxLines: 2,
                              style: textStyle12Normal,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ).paddingAll(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
