import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  final PageController pageController;

  Intro({this.pageController});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          header,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSteps("1. Take a photo of yourself"),
              buildSteps("2. Take a photo of your National ID Card"),
              buildSteps("3. Confirm details"),
              buildSteps("4. Submit registration for verification"),
            ],
          ),
          buildButton("Get Started", pageController),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, PageController pageController) {
    return ElevatedButton(
      onPressed: () async {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      },
      child: Text(buttonText),
    );
  }

  Widget buildSteps(String content) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}

Widget header = Text("Voter Registration");
