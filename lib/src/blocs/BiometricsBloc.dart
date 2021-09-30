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
    final extractionRes = await _repository.extractBiometrics(bioData);

    final matchRes = await _repository.verifyBiometrics(extractionRes);
    // Add response to response stream
    addUser(matchRes);
  }

  dispose() {
    _selfie.close();
    _idCard.close();
    _responseStream.close();
  }
}
