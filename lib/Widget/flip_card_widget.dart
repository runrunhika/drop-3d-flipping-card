import 'dart:math';

import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  final Image front;
  final Image back;

  const FlipCardWidget({Key? key, required this.front, required this.back})
      : super(key: key);

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  bool isFron = true;
  double drogPosition = 0;

  @override
  Widget build(BuildContext context) {
    final angle = drogPosition / 180 * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      // ..rotateY(angle);
      ..rotateX(angle);

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          drogPosition -= details.delta.dx;
          drogPosition %= 360;

          setImageSide();
        });
      },
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: isFron
            ? widget.front
            : Transform(
                transform: Matrix4.identity()..rotateX(pi), child: widget.back),
      ),
    );
  }

  void setImageSide() {
    if (drogPosition <= 90 || drogPosition >= 270) {
      isFron = true;
    } else {
      isFron = false;
    }
  }
}
