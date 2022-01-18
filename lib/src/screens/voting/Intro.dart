import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  final PageController pageController;

  Intro({this.pageController});

  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(),
        buildRegisterGif(context),
        buildSubTitle(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSteps("1. Select a Presidential Candidate and Deputy"),
            buildSteps("2. Select a Paliamentary Candidate"),
            buildSteps("3. Select a County Assembly Ward Candidate"),
            buildSteps("4. Confirm your selections"),
            buildSteps("5. Submit Ballot"),
          ],
        ),
        Container(margin: EdgeInsets.only(top: 20)),
        buildButton("Get Started", pageController),
      ],
    );
  }

  Widget buildHeader() {
    return Text(
      "General Election Ballot Casting",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSubTitle() {
    return Text(
      "The voting process shall be conducted in 5 steps",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildRegisterGif(BuildContext context) {
    return Image.asset(
      "assets/gif/register.gif",
      height: MediaQuery.of(context).size.height * 0.4,
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

  Widget buildButton(String buttonText, PageController pageController) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          pageController.nextPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
        child: Text(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.purple,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }
}
