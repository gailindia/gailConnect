import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
// const Icon(
//     this.icon, {
//     Key? key,
//     this.size,
//     this.color,
//     this.semanticLabel,
//     this.textDirection,
//   }) : super(key: key);
  MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 3000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0); //50.0);
    WidgetsBinding.instance!.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      // await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.linear);
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}

// class MarqueeText extends StatefulWidget {
//   @override
//   _MarqueeTextState createState() => _MarqueeTextState();
// }

// class _MarqueeTextState extends State<MarqueeText> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Marquee Text"),
//         ),
//         body: Center(
//           child: SizedBox(
//               width: 200.0,
//               child: MarqueeWidget(
//                   direction: Axis.horizontal, child: Text("your text"))),
//         ));
//   }
// }
