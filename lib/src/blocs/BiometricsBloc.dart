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
  Stream<User> get user =>
      _responseStream.stream.transform(biometricsValidation);

  final biometricsValidation = StreamTransformer<User, User>.fromHandlers(
    handleData: (user, sink) {
      if (user.idNo.isEmpty) {
        sink.addError("Missing details");
      } else {
        sink.add(user);
      }
    },
  );

  submit() async {
    drainUserStream();
    final selfiePath = _selfie.value;
    final idPath = _idCard.value;

    final Biometrics bioData =
        Biometrics(selfiePath: selfiePath, idCardPath: idPath);

    // recieve response from API
    final extractionRes = await _repository.extractBiometrics(bioData);
    User matchRes;

    if (extractionRes.selfieID.isNotEmpty && extractionRes.cardID.isNotEmpty) {
      matchRes = await _repository.verifyBiometrics(extractionRes);
      matchRes.facePath = selfiePath;
      matchRes.idPath = idPath;
      // Add response to response stream
      addUser(matchRes);
    } else {
      addUser(
        User(
          dob: "",
          faceMatch: false,
          idNo: "",
          name: "",
          sex: "",
          extracted: [""],
          facePath: selfiePath,
          idPath: idPath,
        ),
      );
    }
  }

  drainUserStream() {
    _responseStream.drain();
  }

  dispose() {
    _selfie.close();
    _idCard.close();
    _responseStream.close();
  }
}
