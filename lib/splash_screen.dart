import 'package:flutter/material.dart';
import 'auth/presentation/pages/auth.dart';
import 'package:worldhelps/constants/colors.dart';
import 'constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AuthenticationScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/photos/ic_logo.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  tagline,
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Text(
          "Made in India - Made for World",
          style: TextStyle(color: primaryGrey, fontSize: 11),
        )
      ],
    ));
  }
}
