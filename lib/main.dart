import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/views/home/bloc/weather bloc/weather_bloc.dart';
// import 'app/views/home/home.dart';
import 'app/views/onboarding/onboarding.dart';

// import 'app/views/onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
        // BlocProvider(create: (context) => LocationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          // fontFamily: 'Poppins',
        ),
        home: const Onboarding(),
        // home: const Home(),
      ),
    );
  }
}
