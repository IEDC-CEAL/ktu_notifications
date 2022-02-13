import 'package:flutter/material.dart';
import 'package:ktu_notifications/screens/splash_screen.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      home: const SplashScreen(),
    ),
  );
}
