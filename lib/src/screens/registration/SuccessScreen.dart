import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSuccessIcon(context),
        Container(margin: EdgeInsets.only(top: 30)),
        buildTitle(),
        buildSubTitle(),
      ],
    );
  }

  Widget buildTitle() {
    return Text(
      "Details submitted for verification",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildSubTitle() {
    return Text(
      "Process might take a while you'll be notified once verification is complete",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17,
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
