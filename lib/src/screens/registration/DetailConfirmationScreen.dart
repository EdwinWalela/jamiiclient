import 'package:flutter/material.dart';
import 'package:jamiiclient/src/models/User.dart';

class DetailConfirmationScreen extends StatelessWidget {
  final String header;
  final User user;
  final PageController pageController;

  DetailConfirmationScreen({this.header, this.user, this.pageController});

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
        buildDetail("Face Match", user.faceMatch, ""),
        buildDetail("ID No:", user.idNo.isNotEmpty, user.idNo),
        buildDetail("Name:", user.name.isNotEmpty, user.name),
        buildDetail("Sex:", user.sex.isNotEmpty, user.sex),
        buildDetail("DOB:", user.dob.isNotEmpty, user.dob),
        Container(
          margin: EdgeInsets.only(top: 40),
        ),
        buildButton(checkAllValid(user)),
      ],
    );
  }

  bool checkAllValid(User user) {
    return user.faceMatch &&
        user.idNo.isNotEmpty &&
        user.name.isNotEmpty &&
        user.sex.isNotEmpty &&
        user.dob.isNotEmpty;
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
            isValid ? content + " " + value : content + " " + "N/A",
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
        onPressed: () {
          if (allValid) {
            pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text(allValid ? "Submit" : "Re-take photos"),
      ),
    );
  }
}
