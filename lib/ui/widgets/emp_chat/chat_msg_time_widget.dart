// Created By Amit Jangid on 27/12/21

import 'package:flutter/material.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

class ChatMsgTimeWidget extends StatelessWidget {
  final Color textColor;
  final Timestamp timeStamp;

  const ChatMsgTimeWidget({Key? key, this.textColor = Colors.white, required this.timeStamp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      // calling convert time stamp to time method
      convertTimeStampToTime(timeStamp),
      textAlign: TextAlign.right,
      style: textStyle12Normal.copyWith(fontSize: 10, color: textColor),
    );
  }
}
