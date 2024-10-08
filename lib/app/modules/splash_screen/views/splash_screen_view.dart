import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delay for 5 seconds before redirecting
    Future.delayed(const Duration(seconds: 10), (() {
      controller.redirect();
    }));

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"), // Background image
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated loader using CustomPainter
                _buildLoader(),

                // Digester Logo inside the loader
                Positioned(
                  child: Image(
                    image: AssetImage("images/logo_digester.png"),
                    height: 280, // Adjust size to fit within the loader
                    width: 280,  // Adjust size to fit within the loader
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to create the loader animation
  Widget _buildLoader() {
    return _Loader();
  }
}

class _Loader extends StatefulWidget {
  @override
  __LoaderState createState() => __LoaderState();
}

class __LoaderState extends State<_Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is unmounted
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.1415, // Rotate the arc based on animation
          child: CustomPaint(
            size: Size(300, 300),
            painter: _LoaderPainter(),
          ),
        );
      },
    );
  }
}

class _LoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // Define the full circle
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw 75% arc
    double sweepAngle = 2 * 3.1415 * 0.75; // 75% of a full circle

    canvas.drawArc(rect, -3.1415 / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
