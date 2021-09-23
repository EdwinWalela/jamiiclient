import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/onboarding/OnboardingScreen.dart';
import 'package:jamiiclient/src/screens/registration/RegistrationScreen.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jamii",
      debugShowCheckedModeBanner: false,
      // home: OnBoardingScreen(),
      home: RegistrationScreen(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegistrationScreen()
      },
    );
  }
}
