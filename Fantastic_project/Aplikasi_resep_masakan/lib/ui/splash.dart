import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Ubah Sisa Bahan Menjadi Hidangan Lezat!",
                style: TextStyle(
                  color: Color.fromRGBO(54, 55, 63, 1),
                  fontFamily: 'Euclid Circular A',
                  fontSize: 30,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/image/rafiki.png',
              width: 360,
              height: 270,
            ),
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Aplikasi ini membantu Anda memanfaatkan bahan sisa di dapur untuk menciptakan hidangan lezat dan bergizi.",
                style: TextStyle(
                  color: Color.fromRGBO(54, 55, 63, 1),
                  fontFamily: 'Euclid Circular A',
                  fontSize: 15,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                backgroundColor: const Color.fromRGBO(26, 77, 46, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Mulai',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Euclid Circular A',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Praktikum 6",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Removed navigatorKey
    );
  }
}
