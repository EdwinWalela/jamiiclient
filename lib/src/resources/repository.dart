import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/resources/BioAPIProvider.dart';

class Repository {
  final BioAPIProvider bioAPIProvider = BioAPIProvider();

  Future<void> verifyBiometrics(Biometrics bioData) async {
    final res = await bioAPIProvider.detectFaces(bioData);
    print(res);
    return "";
  }
}
