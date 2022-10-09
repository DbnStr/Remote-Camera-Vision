import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NotificationImageCanvas extends CustomPainter {
  NotificationImageCanvas({required this.image, this.bbox});

  ui.Image? image;
  List<dynamic>? bbox;

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      paintImage(
          canvas: canvas,
          rect: Rect.fromLTRB(0, 0, size.width, size.height),
          image: image!,
          fit: BoxFit.scaleDown
      );

      Size inputSize = Size(image!.width.toDouble(), image!.height.toDouble());
      Size outputSize = Size(size.width.toDouble(), size.height.toDouble());

      Size destinationSize;
      destinationSize = inputSize;
      final double aspectRatio = inputSize.width / inputSize.height;
      if (destinationSize.height > outputSize.height) {
        destinationSize = Size(outputSize.height * aspectRatio, outputSize.height);
      }
      if (destinationSize.width > outputSize.width) {
        destinationSize = Size(outputSize.width, outputSize.width / aspectRatio);
      }

      var scaleX = destinationSize.width / inputSize.width;
      var scaleY = destinationSize.height / inputSize.height;

      var offsetX = (outputSize.width - destinationSize.width) / 2;
      var offsetY = (outputSize.height - destinationSize.height) / 2;

      var framePaint = Paint()
        ..color = Colors.cyan
        ..strokeWidth = 1;

      var leftUp = Offset(bbox![0][0] * scaleX + offsetX, bbox![1][0] * scaleY + offsetY);
      var leftDown = Offset(bbox![0][0] * scaleX + offsetX, bbox![1][1] * scaleY + offsetY);
      var RightUp = Offset(bbox![0][1] * scaleX + offsetX, bbox![1][0] * scaleY + offsetY);
      var downRight = Offset(bbox![0][1] * scaleX + offsetX, bbox![1][1] * scaleY + offsetY);

      canvas.drawLine(leftUp, leftDown, framePaint);
      canvas.drawLine(leftDown, downRight, framePaint);
      canvas.drawLine(downRight, RightUp, framePaint);
      canvas.drawLine(leftUp, RightUp, framePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}