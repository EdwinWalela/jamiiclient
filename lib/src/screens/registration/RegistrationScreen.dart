import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/registration/Biometrics.dart';
import 'package:jamiiclient/src/screens/registration/Intro.dart';

class RegistrationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 1);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
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
          ],
        ),
      ),
    );
  }
}
