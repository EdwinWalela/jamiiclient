import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSuccessIcon(context),
        Container(margin: EdgeInsets.only(top: 30)),
        buildTitle(),
        Container(margin: EdgeInsets.only(top: 10)),
        buildSubTitle(),
      ],
    );
  }

  Widget buildTitle() {
    return Text(
      "Your vote has been cast",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildSubTitle() {
    return Text(
      "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey[700],
      ),
    );
  }

  Widget buildSuccessIcon(BuildContext context) {
    return Icon(
      Icons.check_circle_outline_rounded,
      size: 100,
    );
  }
}
