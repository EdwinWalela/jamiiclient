import 'dart:convert';

import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/models/User.dart';
import 'package:jamiiclient/src/resources/BioAPIProvider.dart';

class Repository {
  final BioAPIProvider bioAPIProvider = BioAPIProvider();

  Future<Biometrics> extractBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.detectFaces(bioData);

    var parsedJson = jsonDecode(res);

    Biometrics bio = Biometrics.fromJson(parsedJson);
    // User user = User.fromJson(parsedJson);
    User user = User(
      idNo: "36914130",
      dob: "26/09/1999",
      name: "Edwin Walela",
      sex: "male",
    );

    bio.user = user;

    return bio;
  }

  Future<User> verifyBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.verifyFaces(bioData);
    var parsedJson = jsonDecode(res);
    User user = bioData.user;
    user.faceMatch = parsedJson["match"] == true;

    return user;
  }
}
