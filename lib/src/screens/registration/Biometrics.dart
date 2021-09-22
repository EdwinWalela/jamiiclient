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
        children: [
          Container(margin: EdgeInsets.only(top: 20)),
          buildHeader(header),
          Container(margin: EdgeInsets.only(top: 40)),
          buildImageFrame(context),
          Container(margin: EdgeInsets.only(top: 40)),
          buildButton("Capture", pageController),
        ],
      ),
    );
  }

  Widget buildHeader(String header) {
    return Text(
      header,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildImageFrame(BuildContext context) {
    return Container(
      width: this.isPotrait
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.8,
      height: this.isPotrait
          ? MediaQuery.of(context).size.width * 0.6
          : MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
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
      ),
    );
  }
}
