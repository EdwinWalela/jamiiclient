class Biometrics {
  String selfieID;
  String cardID;
  List<String> missingFace;

  Biometrics({this.selfieID, this.cardID, this.missingFace});

  Biometrics.fromJson(parsedJson) {
    selfieID = parsedJson["face-id"][0];
    missingFace = parsedJson["missing-face"];
  }
}
