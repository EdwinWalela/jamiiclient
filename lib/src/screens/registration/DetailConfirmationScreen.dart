import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BiometricsBloc.dart';
import 'package:jamiiclient/src/models/User.dart';

class DetailConfirmationScreen extends StatelessWidget {
  final String header;
  final User user;
  final PageController pageController;
  final SimpleKeyPair keyPair;
  final BiometricsBloc biometricsBloc;

  DetailConfirmationScreen({
    this.header,
    this.user,
    this.pageController,
    this.keyPair,
    this.biometricsBloc,
  });

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        user != null ? userValid(context) : noData(),
        Container(
          margin: EdgeInsets.only(top: 40),
        ),
        buildButton(user != null ? checkAllValid(user) : false),
      ],
    );
  }

  Widget userValid(BuildContext context) {
    return Column(
      children: [
        Container(margin: EdgeInsets.only(top: 10)),
        buildHeader(this.header),
        Container(margin: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageFrame(context, user.idPath),
            Container(margin: EdgeInsets.only(right: 20)),
            buildImageFrame(context, user.facePath),
            Container(margin: EdgeInsets.only(right: 20)),
          ],
        ),
        buildDetail("Face Match", user.faceMatch, ""),
        buildDetail("ID No:", user.idNo.isNotEmpty, user.idNo),
        buildDetail("Name:", user.name.isNotEmpty, user.name),
        buildDetail("Sex:", user.sex.isNotEmpty, user.sex),
        buildDetail("DOB:", user.dob.isNotEmpty, user.dob),
      ],
    );
  }

  Widget noData() {
    return Column(
      children: [
        Text("Unable To Extract Details"),
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

  Widget buildImageFrame(BuildContext context, String path) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black, width: 2),
      // ),
      child: path.isNotEmpty
          ? Image.file(
              File(
                path,
              ),
              scale: 2,
            )
          : Container(),
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
        onPressed: () async {
          if (allValid) {
            final algorithim = Ed25519();
            final userData = user.extracted.join("").replaceAll(" ", "");
            final extractedDetails = utf8.encode(userData);
            // produce digest
            final digest = sha512.convert(extractedDetails);
            // sign extracted ID information with users keypair
            final signature = await algorithim.sign(
              utf8.encode(digest.toString()),
              keyPair: keyPair,
            );

            final sig64 = base64Encode(signature.bytes);
            final pubKey = await keyPair.extractPublicKey();
            final pubKey64 = base64Encode(pubKey.bytes);

            // uniquely identify user & save localy
            this.biometricsBloc.addExtractedDetails(digest.toString());

            await this.biometricsBloc.sendExtractedDetails();

            pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            this.biometricsBloc.drainUserStream();
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
