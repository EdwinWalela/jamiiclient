import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTitle(),
        Container(margin: EdgeInsets.only(top: 30)),
        buildSpinner(context),
      ],
    );
  }

  Widget buildTitle() {
    return Text(
      "Performing Checks",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildSpinner(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: LinearProgressIndicator(minHeight: 10),
    );
  }
}