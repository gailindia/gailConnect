// Created By Amit Jangid 13/07/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/dialogs/custom_dialog.dart';

showCustomDialogBox({required BuildContext context, required String title, required String description}) =>
    showCustomDialog(
      context,
      title: title,
      description: description,
      btnStyle: buttonTextStyle,
          btnColor: Colors.black,
          dividerColor: Colors.black
          ,
      // btnColor: kPrimaryDarkColor,
      // dividerColor: kPrimaryDarkColor,
    );
