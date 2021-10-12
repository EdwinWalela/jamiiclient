import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/biometricsBlocProvider.dart';
import 'package:jamiiclient/src/screens/onboarding/OnboardingScreen.dart';
import 'package:jamiiclient/src/screens/registration/RegistrationScreen.dart';

class App extends StatelessWidget {
  final cameras;

  App({this.cameras});

  Widget build(BuildContext context) {
    print("hello world");
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.

        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      title: "Jamii",
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
      // home: BiometricsProvider(
      // child: RegistrationScreen(cameras: this.cameras),
      // ),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => BiometricsProvider(
              child: RegistrationScreen(
                cameras: this.cameras,
              ),
            )
      },
    );
  }
}
