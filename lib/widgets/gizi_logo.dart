import 'package:flutter/material.dart';

class GiziLogo extends StatelessWidget {
  final double size;
  final Color color;

  const GiziLogo({
    super.key,
    this.size = 120,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: GiziLogoPainter(color: color),
      ),
    );
  }
}

class GiziLogoPainter extends CustomPainter {
  final Color color;

  GiziLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.4;

    // Draw the G shape
    final circlePath = Path();
    circlePath.addArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      0.4, // Start angle in radians
      5.0, // Sweep angle in radians
    );

    // Draw the fork-like element at the top
    final forkPath = Path();
    final forkTop = Offset(centerX + radius * 0.7, centerY - radius * 0.8);
    final forkWidth = size.width * 0.15;
    final forkHeight = size.height * 0.2;
    
    forkPath.moveTo(forkTop.dx - forkWidth / 2, forkTop.dy);
    forkPath.lineTo(forkTop.dx + forkWidth / 2, forkTop.dy);
    
    // Draw fork tines
    final tineWidth = forkWidth / 3;
    for (int i = 0; i < 3; i++) {
      final tineX = forkTop.dx - forkWidth / 2 + tineWidth * i;
      forkPath.moveTo(tineX, forkTop.dy);
      forkPath.lineTo(tineX, forkTop.dy - forkHeight * 0.7);
    }

    // Draw the "i" dot
    final iDotRadius = size.width * 0.08;
    final iDotCenter = Offset(centerX + radius * 0.5, centerY - radius * 0.1);
    
    // Draw the "i" body (rectangular part)
    final iBodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX + radius * 0.5, centerY + radius * 0.25),
        width: size.width * 0.15,
        height: size.height * 0.2,
      ),
      Radius.circular(size.width * 0.03),
    );

    // Draw all parts
    canvas.drawPath(circlePath, paint);
    canvas.drawPath(forkPath, paint);
    canvas.drawCircle(iDotCenter, iDotRadius, fillPaint);
    canvas.drawRRect(iBodyRect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
