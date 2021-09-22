import 'package:flutter/material.dart';

class DetailConfirmationScreen extends StatelessWidget {
  final String header;

  DetailConfirmationScreen({this.header});

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(margin: EdgeInsets.only(top: 20)),
        buildHeader(this.header),
        Container(margin: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageFrame(context),
            Container(margin: EdgeInsets.only(right: 20)),
            buildImageFrame(context),
            Container(margin: EdgeInsets.only(right: 20)),
          ],
        ),
        buildDetail("Face Match", false, ""),
        buildDetail("ID No:", true, "36914130"),
        buildDetail("Name:", true, "Edwin Walela"),
        buildDetail("Sex:", true, "Male"),
        buildDetail("DOB:", true, "26/09/1999"),
        Container(margin: EdgeInsets.only(top: 40)),
        buildButton(false),
      ],
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
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }

  Widget buildDetail(String content, bool isValid, String value) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 40),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_rounded : Icons.close,
            color: isValid ? Colors.green[900] : Colors.red,
            size: 30,
          ),
          Container(margin: EdgeInsets.only(right: 10)),
          Text(
            content + " " + value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton(bool allValid) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(allValid ? "Submit" : "Re-take photo"),
      ),
    );
  }
}
