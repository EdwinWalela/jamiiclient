import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/registration/Biometrics.dart';
import 'package:jamiiclient/src/screens/registration/CheckingScreen.dart';
import 'package:jamiiclient/src/screens/registration/Intro.dart';

class RegistrationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 3);

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
                header: "Step 1: Take a photo of yourself",
                isPotrait: true,
                pageController: pageController),
            Biometrics(
                header: "Step 2: Take a photo of your National ID",
                isPotrait: false,
                pageController: pageController),
            CheckingScreen(),
          ],
        ),
      ),
    );
  }
}
