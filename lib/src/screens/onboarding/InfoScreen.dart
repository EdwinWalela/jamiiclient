import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String buttonText;

  InfoScreen({this.index, this.title, this.description, this.buttonText});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 50),
      child: Column(
        children: [
          buildTitle(this.title, this.description),
          Expanded(
            child: buildSVG(),
          ),
          buildButton(buttonText)
        ],
      ),
    );
  }

  Widget buildTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(margin: EdgeInsets.only(top: 15)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget buildSVG() {
    return Container();
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: null,
      child: Text(buttonText),
    );
  }
}
