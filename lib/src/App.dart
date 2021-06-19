import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/onboarding/OnBoardingContainer.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jamii",
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
