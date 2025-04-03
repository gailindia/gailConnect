// Created by AMIT JANGID on 17/12/20.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// This widget will display a text in hyper link format
/// This widget uses [launch] method from [url_launcher] package
class HyperLinkTextWidget extends StatelessWidget {
  final String url, text;
  final EdgeInsetsGeometry padding;

  const HyperLinkTextWidget({Key? key, this.padding = const EdgeInsets.all(12), required this.url, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("url HyperLinkTextWidget :: $url");
    return InkWell(
      onTap: () async => await launch(url),
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
