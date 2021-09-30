import 'dart:convert';

import 'package:http/http.dart';
import 'package:jamiiclient/src/models/Biometrics.dart';

class BioAPIProvider {
  Client client = Client();
  String _baseURL = "https://aa21-197-237-160-234.ngrok.io";

  Future<String> detectFaces(Biometrics bioData) async {
    var url = Uri.parse('$_baseURL/detect');

    var request = MultipartRequest("POST", url);

    var selfie = await MultipartFile.fromPath("face", bioData.selfiePath);
    var id = await MultipartFile.fromPath("id", bioData.idCardPath);

    request.files.add(id);
    request.files.add(selfie);

    final response = await request.send();
    var resData = await response.stream.toBytes();
    var res = String.fromCharCodes(resData);
    return res;
  }

  Future<String> verifyFaces(Biometrics bioData) async {
    // Send IDs for face match verification
    var url = Uri.parse('$_baseURL/verify');
    Map data = {
      "face1": bioData.selfieID,
      "face2": bioData.cardID,
    };

    var body = jsonEncode(data);

    final res = await client.post(url, body: body);
    return res.body;
  }
}
