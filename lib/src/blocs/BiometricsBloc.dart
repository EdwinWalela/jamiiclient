import 'dart:async';
import 'dart:io';

import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/models/User.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BiometricsBloc {
  final _repository = Repository();
  final _selfie = BehaviorSubject<String>();
  final _idCard = BehaviorSubject<String>();
  final _responseStream = BehaviorSubject<User>();

  // Getters
  Function(String) get addSelfie => _selfie.sink.add;
  Stream<String> get selfie => _selfie.stream;

  Function(String) get addId => _idCard.sink.add;
  Stream<String> get idCard => _idCard.stream;

  Function(User) get addUser => _responseStream.sink.add;
  Stream<User> get user => _responseStream.stream;

  submit() async {
    final selfiePath = _selfie.value;
    final idPath = _idCard.value;

    final Biometrics bioData =
        Biometrics(selfiePath: selfiePath, idCardPath: idPath);

    // recieve response from API
    final res = await _repository.extractBiometrics(bioData);
    final user = User(
      faceMatch: res.missingFaces.isNotEmpty,
      name: "Edwin Walela",
      idNo: "36914130",
      sex: "male",
      dob: "26/09/1999",
    );
    // Add response to response stream
    addUser(user);
  }

  dispose() {
    _selfie.close();
    _idCard.close();
    _responseStream.close();
  }
}
