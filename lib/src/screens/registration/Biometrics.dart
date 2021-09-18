import 'package:flutter/material.dart';

class Biometrics extends StatelessWidget {
  final String header;
  final bool isPotrait;
  final PageController pageController;

  Biometrics({this.header, this.isPotrait, this.pageController});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 60, 30, 50),
      child: Column(
        children: [buildHeader(header), buildButton("Capture", pageController)],
      ),
    );
  }

  Widget buildHeader(String header) {
    return Text(header);
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
