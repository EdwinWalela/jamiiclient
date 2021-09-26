import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/registration/Biometrics.dart';
import 'package:jamiiclient/src/screens/registration/CheckingScreen.dart';
import 'package:jamiiclient/src/screens/registration/DetailConfirmationScreen.dart';
import 'package:jamiiclient/src/screens/registration/Intro.dart';
import 'package:jamiiclient/src/screens/registration/SuccessScreen.dart';

class RegistrationScreen extends StatelessWidget {
  final cameras;

  RegistrationScreen({this.cameras});

  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 1);

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
                pageController: pageController),
            Biometrics(
                camera: this.cameras[0],
                header: "Step 2: Take a photo of your National ID",
                isPotrait: false,
                pageController: pageController),
            CheckingScreen(),
            DetailConfirmationScreen(
              header: "Step 3: Confirm Registration Details",
            ),
            SuccessScreen(),
          ],
        ),
      ),
    );
  }
}
