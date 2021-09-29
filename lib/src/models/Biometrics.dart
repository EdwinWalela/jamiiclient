import 'dart:io';

class Biometrics {
  String selfieID;
  String cardID;
  List<String> missingFace;
  String selfiePath;
  String idCardPath;

  Biometrics({
    this.selfieID,
    this.cardID,
    this.missingFace,
    this.selfiePath,
    this.idCardPath,
  });

  Biometrics.fromJson(parsedJson) {
    selfieID = parsedJson["face-id"][0];
    missingFace = parsedJson["missing-face"];
  }
}
