import 'package:http/http.dart';
import 'package:jamiiclient/src/models/Biometrics.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

class BioAPIProvider {
  Client client = Client();
  String _baseURL = "https://d9eb-197-237-160-234.ngrok.io";

  Future<String> detectFaces(Biometrics bioData) async {
    var url = Uri.parse('$_baseURL/detect');

    var request = MultipartRequest("POST", url);

    var selfie = await MultipartFile.fromPath("selfie", bioData.selfiePath);
    var id = await MultipartFile.fromPath("id", bioData.idCardPath);

    request.files.add(selfie);
    request.files.add(id);

    final response = await request.send();
    var resData = await response.stream.toBytes();
    var res = String.fromCharCodes(resData);
    return res;
  }
}
