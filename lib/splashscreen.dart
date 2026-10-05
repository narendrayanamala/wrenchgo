
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wrenchgo/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FF),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // Wrench Icon
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.build,
                size: 75,
                color: Color(0xFF115FCC),
              ),
            ),

            const SizedBox(height: 25),

            // App Name
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Wrench',
                    style: TextStyle(
                      color: Color(0xFF115FCC),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' Go',
                    style: TextStyle(
                      color: Color(0xFFFF6B00),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'ROADSIDE ASSISTANCE MADE EASY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            // Bottom section
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFF115FCC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.car_repair,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
