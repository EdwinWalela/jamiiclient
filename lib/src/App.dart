import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/onboarding/OnboardingScreen.dart';
import 'package:jamiiclient/src/screens/registration/RegistrationScreen.dart';

class App extends StatelessWidget {
  final cameras;

  App({this.cameras});

  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(colorScheme: ColorScheme(background: Colors.white,)),
      title: "Jamii",
      debugShowCheckedModeBanner: false,
      // home: OnBoardingScreen(),
      home: RegistrationScreen(cameras: this.cameras),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegistrationScreen(
              cameras: this.cameras,
            )
      },
    );
  }
}
