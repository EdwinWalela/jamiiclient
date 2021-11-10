import 'dart:ffi';

import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:rxdart/rxdart.dart';

class BallotBloc {
  final _presidential = BehaviorSubject<Candidate>();
  final _parliamentary = BehaviorSubject<Candidate>();
  final _county = BehaviorSubject<Candidate>();

  Function(Candidate) get addPresidential => _presidential.sink.add;
  Function(Candidate) get addParliamentary => _parliamentary.sink.add;
  Function(Candidate) get addCounty => _county.sink.add;

  Stream<Candidate> get presidential => _presidential.stream;
  Stream<Candidate> get parliamentary => _parliamentary.stream;
  Stream<Candidate> get county => _county.stream;

  submit() async {
    final presidentialCandidate = _presidential.value;
    final parliamentaryCandidate = _parliamentary.value;
    final countyCandidate = _county.value;
  }

  dispose() {
    _presidential.close();
    _parliamentary.close();
    _county.close();
  }
}
