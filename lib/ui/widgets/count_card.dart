// Created By Amit Jangid 21/10/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/widgets/material_card.dart';

class CountCard extends StatelessWidget {
  final int count;
  final Color color;
  final String title;
  final GestureTapCallback? onTap;

  const CountCard({Key? key, required this.count, required this.title, required this.color, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: MaterialCard(
          onTap: onTap,
          color: color,
          borderRadius: 12,
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(top: 12, left: 6, right: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$count', style: textStyle30Bold.copyWith(fontSize: 42, color: Colors.white)),
              FittedBox(child: Text(title, textAlign: TextAlign.center, style: textStyle14Bold.copyWith(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}
