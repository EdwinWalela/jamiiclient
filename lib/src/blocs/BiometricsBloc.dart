import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';

class BiometricsBloc {
  final _selfie = BehaviorSubject<File>();
  final _idCard = BehaviorSubject<String>();

  // Getters
  Function(File) get addSelfie => _selfie.sink.add;
  Stream<File> get selfie => _selfie.stream.transform(validate);

  Function(String) get addId => _idCard.sink.add;
  Stream<String> get idCard => _idCard.stream;

  final validate =
      StreamTransformer<File, File>.fromHandlers(handleData: (file, sink) {});

  submit() async {}

  dispose() {
    _selfie.close();
    _idCard.close();
  }
}
