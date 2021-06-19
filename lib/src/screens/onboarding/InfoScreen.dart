import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String buttonText;
  final bool svgTop;

  InfoScreen(
      {this.index, this.title, this.description, this.buttonText, this.svgTop});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 60, 30, 50),
      child: Column(
        children: [
          this.svgTop
              ? buildsvgTop(this.title, this.description)
              : buildsvgBottom(this.title, this.description),
          buildButton(buttonText)
        ],
      ),
    );
  }

  Widget buildsvgTop(String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          buildSVG(),
          buildTitle(title, subtitle),
          Container(
            margin: EdgeInsets.only(bottom: 50),
          )
        ],
      ),
    );
  }

  Widget buildsvgBottom(String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          buildTitle(title, subtitle),
          buildSVG(),
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
    return Expanded(
      child: Container(),
    );
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: null,
      child: Text(buttonText),
    );
  }
}
