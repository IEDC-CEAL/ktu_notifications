import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';

import 'package:animated_page_transition/animated_page_transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/cubit/home_screen_cubit.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Center(
                child: AnimatedTextKit(
                  totalRepeatCount: 5,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'MADE IN LOVE WITH FLUTTER',
                      textStyle: GoogleFonts.comfortaa(
                          color: const Color.fromARGB(255, 16, 26, 18),
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    TypewriterAnimatedText(
                      'BY COLLEGE OF ENGINEERING ATTINGAL',
                      textStyle: GoogleFonts.comfortaa(
                          color: const Color.fromARGB(255, 16, 26, 18),
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
            ),
            Center(
              child: PageTransitionButton(
                vsync: this,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Click Here",
                      style: GoogleFonts.comfortaa(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                nextPage: BlocProvider(
                  create: (context) => HomeScreenCubit(),
                  child: const HomeScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
