import 'dart:io';

import 'package:jamiiclient/src/models/User.dart';

class Biometrics {
  String selfieID;
  String cardID;
  List<String> missingFaces;
  String selfiePath;
  String idCardPath;
  User user;

  Biometrics({
    this.selfieID,
    this.cardID,
    this.missingFaces,
    this.selfiePath,
    this.idCardPath,
    this.user,
  });

  Biometrics.fromJson(parsedJson) {
    List<String> faces = List<String>.from(parsedJson["face-id"]);
    selfieID = faces.length != 0 ? faces[0] : "";
    cardID = faces.length == 2 ? faces[1] : "";
    missingFaces = List.castFrom<dynamic, String>(
      parsedJson["missing-face"],
    );
  }
}
