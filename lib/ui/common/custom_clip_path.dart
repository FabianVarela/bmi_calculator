import 'package:flutter/cupertino.dart';

class TriangleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class WaveClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height - 20);

    final Offset firstInitialPoint = Offset(size.width / 4, size.height);
    final Offset firstEndPoint = Offset(size.width / 2.25, size.height - 30);

    path.quadraticBezierTo(firstInitialPoint.dx, firstInitialPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final Offset secondInitialPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    final Offset secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(secondInitialPoint.dx, secondInitialPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
