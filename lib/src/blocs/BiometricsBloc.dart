import 'dart:async';
import 'dart:io';

import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BiometricsBloc {
  final _repository = Repository();
  final _selfie = BehaviorSubject<String>();
  final _idCard = BehaviorSubject<String>();

  // Getters
  Function(String) get addSelfie => _selfie.sink.add;
  Stream<String> get selfie => _selfie.stream.transform(validate);

  Function(String) get addId => _idCard.sink.add;
  Stream<String> get idCard => _idCard.stream;

  final validate = StreamTransformer<String, String>.fromHandlers(
      handleData: (file, sink) {});

  submit() async {
    final selfiePath = _selfie.value;
    final idPath = _idCard.value;

    final Biometrics bioData =
        Biometrics(selfiePath: selfiePath, idCardPath: idPath);

    await _repository.verifyBiometrics(bioData);
  }

  dispose() {
    _selfie.close();
    _idCard.close();
  }
}
