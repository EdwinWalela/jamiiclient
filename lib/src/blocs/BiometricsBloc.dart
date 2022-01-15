import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
  final _regHash = BehaviorSubject<String>();

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

  Function(String) get addRegHash => _regHash.sink.add;
  Stream<String> get regHash => _regHash.stream;

  final biometricsValidation = StreamTransformer<User, User>.fromHandlers(
    handleData: (user, sink) {
      if (user.idNo.isEmpty) {
        sink.addError("Missing details");
      } else {
        sink.add(user);
      }
    },
  );

  mockRegistration() async {
    final keyPair = _keyPair.value;

    final algorithim = Ed25519();
    final hash =
        "b5300a79468cf8cac475a0fd892a65339e3b90c4755d77b643a38b75d2820b3c2c6884466c37c60de3deb05cba9798ed07646cb81b268fe98bdb0286de4bbffc";
    // sign extracted ID information with users keypair
    final signature = await algorithim.sign(
      utf8.encode(hash),
      keyPair: keyPair,
    );

    final sig64 = base64Encode(signature.bytes);
    final pubKey = await keyPair.extractPublicKey();
    final pubKey64 = base64Encode(pubKey.bytes);
    _repository.mockRegistration("$hash|$pubKey64|$sig64");
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
    final keyPair = _keyPair.value;
    final pubKey = await keyPair.extractPublicKey();
    final pubKey64 = base64Encode(pubKey.bytes);
    _repository.registerVoter(details + "|" + pubKey64);
  }

  drainUserStream() {
    // await _responseStream.drain();
  }

  retriveHash() async {
    final hash = await _repository.retrieveHash();

    if (hash.length > 0) {
      addRegHash(hash[0]);
    } else {
      _regHash.sink.addError("hash missing");
    }
  }

  dispose() {
    _selfie.close();
    _idCard.close();
    _responseStream.close();
    _extractedDetails.close();
    _regHash.close();
    _keyPair.close();
  }
}
