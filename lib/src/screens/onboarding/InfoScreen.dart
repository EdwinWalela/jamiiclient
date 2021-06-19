import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String buttonText;
  final bool svgTop;
  final String iconFile;

  InfoScreen(
      {this.index,
      this.title,
      this.description,
      this.buttonText,
      this.svgTop,
      this.iconFile});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 60, 30, 50),
      child: Column(
        children: [
          this.svgTop
              ? buildsvgTop(this.title, this.description, this.iconFile)
              : buildsvgBottom(this.title, this.description, this.iconFile),
          buildButton(buttonText)
        ],
      ),
    );
  }

  Widget buildsvgTop(String title, String subtitle, String iconFile) {
    return Expanded(
      child: Column(
        children: [
          buildSVG(iconFile),
          buildTitle(title, subtitle),
          Container(
            margin: EdgeInsets.only(bottom: 50),
          )
        ],
      ),
    );
  }

  Widget buildsvgBottom(String title, String subtitle, String iconFile) {
    return Expanded(
      child: Column(
        children: [
          buildTitle(title, subtitle),
          buildSVG(iconFile),
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

  Widget buildSVG(String iconFile) {
    return Expanded(child: Image.asset(iconFile));
  }

  Widget buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: null,
      child: Text(buttonText),
    );
  }
}
