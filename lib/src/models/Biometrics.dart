import 'dart:io';

class Biometrics {
  String selfieID;
  String cardID;
  List<String> missingFaces;
  String selfiePath;
  String idCardPath;

  Biometrics({
    this.selfieID,
    this.cardID,
    this.missingFaces,
    this.selfiePath,
    this.idCardPath,
  });

  Biometrics.fromJson(parsedJson) {
    List<String> faces = parsedJson["face-id"].toString().split(",");
    selfieID = faces[0];
    cardID = faces.length == 2 ? faces[1] : "";
    missingFaces = List.castFrom<dynamic, String>(parsedJson["missing-face"]);
  }
}
