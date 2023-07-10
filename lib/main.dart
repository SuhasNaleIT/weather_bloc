import 'package:flutter/material.dart';
// import 'app/views/home/home.dart';
import 'app/views/onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor: const Color.fromRGBO(186, 68, 197, 1),
        fontFamily: 'Poppins',
      ),
      home: const Onboarding(),
      // home: const Home(),
    );
  }
}
