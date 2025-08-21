import 'dart:math';

import 'package:flutter/material.dart';

import 'package:confetti/confetti.dart';

class AnimatedBalloons extends StatefulWidget {
  const AnimatedBalloons({Key? key}) : super(key: key);

  @override
  _AnimatedBalloonState createState() => _AnimatedBalloonState();
}

class _AnimatedBalloonState extends State<AnimatedBalloons>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animationFloatUpA, _animationFloatUpB;
  Animation<double>? _animationGrowSize;

  double? _balloonHeight;
  double? _balloonWidth;
  double? _balloonBottomLocation;
  bool? visible = true;
  String? balName;

  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(milliseconds: 300));
    _controllerBottomCenter.play();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _balloonHeight = MediaQuery.of(context).size.height / 3; //2
    _balloonWidth = MediaQuery.of(context).size.height / 4; //3
    _balloonBottomLocation =
        MediaQuery.of(context).size.height - _balloonHeight!;

    _animationFloatUpA = Tween(begin: _balloonBottomLocation, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _animationFloatUpB = Tween(begin: _balloonBottomLocation, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _animationGrowSize = Tween(begin: 100.0, end: _balloonWidth! / 2).animate(
      //50
      //50
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(0.0, 0.75, curve: Curves.elasticInOut),
      ),
    );

    if (_controller!.isCompleted) {
      _controller!.reverse();
    } else {
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: visible!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AnimatedBuilder(
              //   animation: _animationFloatUpA!,
              //   builder: (context, child) {
              //     return Container(
              //       child: child,
              //       margin: EdgeInsets.only(
              //         top: _animationFloatUpA!.value * 0.5,
              //         left: _animationGrowSize!.value * 0.25,
              //       ),
              //       width: _animationGrowSize!.value,
              //     );
              //   },
              //   child: GestureDetector(
              //     child: Image.asset(
              //       'assets/icons/balloon1.png',
              //       height: _balloonHeight,
              //       width: _balloonWidth,
              //     ),
              //     onTap: () {
              //       if (_controller!.isCompleted) {
              //         _toggleVisibility();
              //         // _controller!.reverse();
              //       } else {
              //         _controller!.forward();
              //       }
              //     },
              //   ),
              // ),
              AnimatedBuilder(
                animation: _animationFloatUpB!,
                builder: (context, child) {
                  return Container(
                    // color: Colors.amber,
                    child: child,
                    margin: EdgeInsets.only(
                      top: _animationFloatUpB!.value * 0.1,
                      left: _animationGrowSize!.value * 2.6,
                    ),
                    width: _animationGrowSize!.value * 0.3,
                  );
                },
                child: GestureDetector(
                  child: Image.asset(
                    'assets/icons/balloon2.png',
                    height: _balloonHeight,
                    width: _balloonWidth,
                  ),
                  onTap: () {
                    if (_controller!.isCompleted) {
                      _toggleVisibility();
                      // _controller!.reverse();
                    } else {
                      _controller!.forward();
                    }
                  },
                ),
              ),
              //1stballoon
              // AnimatedBuilder(
              //   animation: _animationFloatUpB!,
              //   builder: (context, child) {
              //     return Container(
              //       child: child,
              //       margin: EdgeInsets.only(
              //         top: _animationFloatUpB!.value * 0.1,
              //         left: _animationGrowSize!.value * 0.25,
              //       ),
              //       width: _animationGrowSize!.value * 0.7,
              //     );
              //   },
              //   child: GestureDetector(
              //     child: Image.asset(
              //       'assets/icons/balloon3.png',
              //       height: _balloonHeight,
              //       width: _balloonWidth,
              //     ),
              //     onTap: () {
              //       if (_controller!.isCompleted) {
              //         _toggleVisibility();
              //         // _controller!.reverse();
              //       } else {
              //         _controller!.forward();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),

        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       ConfettiWidget(
        //         confettiController: _controllerBottomCenter,
        //         blastDirection: -pi / 2,
        //         emissionFrequency: 0.01,
        //         numberOfParticles: 20,
        //         maxBlastForce: 100,
        //         minBlastForce: 80,
        //         gravity: 0.3,
        //       ),
        //       ConfettiWidget(
        //         confettiController: _controllerBottomCenter,
        //         blastDirection: -pi / 2,
        //         emissionFrequency: 0.01,
        //         numberOfParticles: 20,
        //         maxBlastForce: 100,
        //         minBlastForce: 80,
        //         gravity: 0.3,
        //       ),
        //       ConfettiWidget(
        //         confettiController: _controllerBottomCenter,
        //         blastDirection: -pi / 2,
        //         emissionFrequency: 0.01,
        //         numberOfParticles: 20,
        //         maxBlastForce: 100,
        //         minBlastForce: 80,
        //         gravity: 0.3,
        //       ),
        //     ],
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: TextButton(
        //       onPressed: () {
        //         _controllerBottomCenter.play();
        //       },
        //       child: _display('hard and infrequent')),
        // ),
      ],
    );
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  _toggleVisibility() {
    setState(() {
      visible = !visible!;
    });
  }
}
