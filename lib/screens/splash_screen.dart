import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = '/splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFFF0C46A);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(.1),
                border: Border.all(color: color, width: 2),
              ),
              alignment: Alignment.center,
              child: Text('Z', style: TextStyle(
                color: color, fontSize: 40, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 16),
            Text('ZEUS Premium', style: TextStyle(
              color: color, fontSize: 18, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
