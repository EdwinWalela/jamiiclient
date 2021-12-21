import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBlocProvider.dart';
import 'package:jamiiclient/src/blocs/biometricsBlocProvider.dart';
import 'package:jamiiclient/src/screens/onboarding/OnboardingScreen.dart';
import 'package:jamiiclient/src/screens/registration/RegistrationScreen.dart';
import 'package:jamiiclient/src/screens/voting/Voting.dart';

class App extends StatelessWidget {
  final cameras;
  final keyPair;

  App({this.cameras, this.keyPair});

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      title: "Jamii",
      debugShowCheckedModeBanner: false,
      // home: OnBoardingScreen(),
      // home: BallotBlocProvider(
      //   child: VotingScreen(keyPair: this.keyPair),
      // ),
      home: BiometricsProvider(
        child: RegistrationScreen(
          cameras: this.cameras,
          keyPair: this.keyPair,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => BiometricsProvider(
              child: RegistrationScreen(
                cameras: this.cameras,
                keyPair: this.keyPair,
              ),
            )
      },
    );
  }
}
