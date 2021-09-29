import 'dart:convert';

import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/resources/BioAPIProvider.dart';

class Repository {
  final BioAPIProvider bioAPIProvider = BioAPIProvider();

  Future<void> verifyBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.detectFaces(bioData);

    var parsedJson = jsonDecode(res);

    Biometrics bio = Biometrics.fromJson(parsedJson);
    print(bio.missingFaces);
    // var data = R"ce7fbc8d-f155-41a4-bfac-f994bd251188","3d65d1c5-0cab-476d-b808-7c49a7921afc"
    return "";
  }
}
