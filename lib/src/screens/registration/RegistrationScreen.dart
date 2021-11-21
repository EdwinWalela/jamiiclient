import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BiometricsBloc.dart';
import 'package:jamiiclient/src/blocs/biometricsBlocProvider.dart';
import 'package:jamiiclient/src/models/User.dart';
import 'package:jamiiclient/src/screens/registration/Biometrics.dart';
import 'package:jamiiclient/src/screens/registration/CheckingScreen.dart';
import 'package:jamiiclient/src/screens/registration/DetailConfirmationScreen.dart';
import 'package:jamiiclient/src/screens/registration/Intro.dart';
import 'package:jamiiclient/src/screens/registration/SuccessScreen.dart';

class RegistrationScreen extends StatelessWidget {
  final cameras;
  final keyPair;

  RegistrationScreen({this.cameras, this.keyPair});

  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    final BiometricsBloc biometricsBloc = BiometricsProvider.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: pageController,
          children: [
            Intro(pageController: pageController),
            Biometrics(
              camera: this.cameras[1],
              header: "Step 1: Take a photo of yourself",
              isPotrait: true,
              pageController: pageController,
              biometricsBloc: biometricsBloc,
            ),
            Biometrics(
              camera: this.cameras[0],
              header: "Step 2: Take a photo of your National ID",
              isPotrait: false,
              pageController: pageController,
              biometricsBloc: biometricsBloc,
            ),
            // Listen to response stream for data
            StreamBuilder(
              stream: biometricsBloc.user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return DetailConfirmationScreen(
                    header: "Step 3: Confirm Registration Details",
                    user: snapshot.data,
                    pageController: pageController,
                    keyPair: this.keyPair,
                  );
                } else if (snapshot.hasError) {
                  return DetailConfirmationScreen(
                    header: "Step 3: Confirm Registration Details",
                    user: null,
                    pageController: pageController,
                    keyPair: this.keyPair,
                  );
                } else {
                  return CheckingScreen(
                    pageController: pageController,
                  );
                }
              },
            ),

            SuccessScreen(),
          ],
        ),
      ),
    );
  }
}
