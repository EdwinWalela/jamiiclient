import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  final PageController pageController;

  Intro({this.pageController});

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(margin: EdgeInsets.only(top: 50)),
        buildHeader(),
        buildRegisterGif(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSteps("1. Take a photo of yourself"),
            buildSteps("2. Take a photo of your National ID Card"),
            buildSteps("3. Confirm details"),
            buildSteps("4. Submit registration for verification"),
          ],
        ),
        Container(margin: EdgeInsets.only(top: 80)),
        buildButton("Get Started", pageController),
      ],
    );
  }

  Widget buildHeader() {
    return Text(
      "Voter Registration",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildRegisterGif() {
    return Image.asset(
      "assets/gif/register.gif",
    );
  }

  Widget buildButton(String buttonText, PageController pageController) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        child: Text(buttonText),
      ),
    );
  }

  Widget buildSteps(String content) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
