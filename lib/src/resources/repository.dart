import 'dart:convert';
import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/models/User.dart';
import 'package:jamiiclient/src/resources/BioAPIProvider.dart';
import 'package:jamiiclient/src/resources/DBProvider.dart';
import 'package:jamiiclient/src/resources/SocketProvider.dart';

class Repository {
  final BioAPIProvider bioAPIProvider = BioAPIProvider();
  final SocketProvider socketProvider = SocketProvider();

  Future<void> addHash(String hash) async {
    print("adding hash");
    await dbProvider.init();
    await dbProvider.add(hash);
    await dbProvider.close();
    final repo = Repository();
  }

  Future<List<dynamic>> retrieveHash() async {
    print("retrieving hash");
    await dbProvider.init();
    final hash = await dbProvider.fetchHash();
    await dbProvider.close();
    return hash;
  }

  Future<Biometrics> extractBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.detectFaces(bioData);
    print(res);
    var parsedJson = jsonDecode(res);

    Biometrics bio = Biometrics.fromJson(parsedJson);
    User user;

    if (bio.extractedText.length >= 8) {
      user = User(
        idNo: bio.extractedText[1],
        dob: bio.extractedText[3],
        name: bio.extractedText[2],
        sex: bio.extractedText[4],
        idPath: bioData.idCardPath,
        facePath: bioData.selfiePath,
        extracted: bio.extractedText,
      );
      bio.user = user;
    } else {
      bio.user = User(
        faceMatch: false,
        idNo: "",
        dob: "",
        name: "",
        sex: "",
        extracted: bio.extractedText,
        idPath: "",
        facePath: "",
      );
    }

    return bio;
  }

  Future<User> verifyBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.verifyFaces(bioData);
    var parsedJson = jsonDecode(res);
    print(res);
    User user = bioData.user;
    user.faceMatch = parsedJson["match"] == true;

    return user;
  }

  registerVoter(String details) {
    socketProvider.registerVoter(details);
  }

  mockRegistration(String details) {
    socketProvider.mockRegistration(details);
  }

  mockVote() {
    socketProvider.mockVote();
  }

  Future<bool> sendVote(String vote) async {
    final res = await socketProvider.sendVote(vote);

    return res;
  }
}
