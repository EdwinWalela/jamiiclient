import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  final PageController pageController;

  Intro({this.pageController});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [header, buildButton("Get Started", pageController)],
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
}

Widget header = Text("Voter Registration");
