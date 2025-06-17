import 'package:family_shop/home.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? _controller;
  double duration = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/anime1.json',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
              controller: _controller,
              onLoaded: (composition) {
                _controller!
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            SizedBox(height: 10),
            Text(
              "Oila Marketi",
              style: TextStyle(
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() async {
    await Future.delayed(_controller?.duration ?? Duration(seconds: 5));
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
}
