import 'package:flutter/material.dart';

enum DashLineDirection { vertical, horizontal }

class DashedLine extends StatelessWidget {
  final double length;
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final DashLineDirection direction;

  const DashedLine({
    Key? key,
    this.length = 100,
    this.color = Colors.black,
    this.dashWidth = 5,
    this.dashSpace = 5,
    this.direction = DashLineDirection.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: direction == DashLineDirection.vertical ? length : null,
      width: direction == DashLineDirection.horizontal ? length : null,
      child: CustomPaint(
        painter: _DashPainter(
          color: color,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          direction: direction,
        ),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final DashLineDirection direction;

  _DashPainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.direction,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double start = 0;
    if (direction == DashLineDirection.vertical) {
      while (start < size.height) {
        canvas.drawLine(Offset(0, start), Offset(0, start + dashWidth), paint);
        start += dashWidth + dashSpace;
      }
    } else {
      while (start < size.width) {
        canvas.drawLine(Offset(start, 0), Offset(start + dashWidth, 0), paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
