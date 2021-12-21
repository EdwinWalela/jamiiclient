import 'dart:async';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:jamiiclient/src/models/Biometrics.dart';
import 'package:jamiiclient/src/models/User.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BiometricsBloc {
  final _repository = Repository();
  final _selfie = BehaviorSubject<String>();
  final _idCard = BehaviorSubject<String>();
  final _responseStream = BehaviorSubject<User>();
  final _extractedDetails = BehaviorSubject<String>();
  final _keyPair = BehaviorSubject<SimpleKeyPair>();

  // Getters

  Function(SimpleKeyPair) get addKeyPair => _keyPair.sink.add;
  Stream<SimpleKeyPair> get keyPair => _keyPair.stream;

  Function(String) get addSelfie => _selfie.sink.add;
  Stream<String> get selfie => _selfie.stream;

  Function(String) get addId => _idCard.sink.add;
  Stream<String> get idCard => _idCard.stream;

  Function(User) get addUser => _responseStream.sink.add;
  Stream<User> get user =>
      _responseStream.stream.transform(biometricsValidation);

  Function(String) get addExtractedDetails => _extractedDetails.sink.add;
  Stream<String> get extractedDetails => _extractedDetails.stream;

  final biometricsValidation = StreamTransformer<User, User>.fromHandlers(
    handleData: (user, sink) {
      if (user.idNo.isEmpty) {
        sink.addError("Missing details");
      } else {
        sink.add(user);
      }
    },
  );

  mockRegistration() {
    _repository.mockRegistration();
  }

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

  sendExtractedDetails() async {
    final details = _extractedDetails.value;
    _repository.registerVoter(details);
  }

  drainUserStream() {
    // await _responseStream.drain();
    addUser(
      User(
        dob: "redo",
        faceMatch: false,
        idNo: "",
        name: "",
        sex: "",
        extracted: [""],
        facePath: "",
        idPath: "",
      ),
    );
  }

  dispose() {
    _selfie.close();
    _idCard.close();
    _responseStream.close();
    _extractedDetails.close();
  }
}
