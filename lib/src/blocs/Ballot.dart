import 'dart:convert';
import 'dart:ffi';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:jamiiclient/src/models/Vote.dart';
import 'package:rxdart/rxdart.dart';

class BallotBloc {
  final _presidential = BehaviorSubject<Candidate>();
  final _parliamentary = BehaviorSubject<Candidate>();
  final _county = BehaviorSubject<Candidate>();
  final _keyPair = BehaviorSubject<SimpleKeyPair>();

  Function(Candidate) get addPresidential => _presidential.sink.add;
  Function(Candidate) get addParliamentary => _parliamentary.sink.add;
  Function(Candidate) get addCounty => _county.sink.add;
  Function(SimpleKeyPair) get addSignature => _keyPair.sink.add;

  Stream<Candidate> get presidential => _presidential.stream;
  Stream<Candidate> get parliamentary => _parliamentary.stream;
  Stream<Candidate> get county => _county.stream;

  submit() async {
    final presidentialCandidate = _presidential.value;
    final parliamentaryCandidate = _parliamentary.value;
    final countyCandidate = _county.value;
    final keyPair = _keyPair.value;

    var vote = Vote(
      presidential: presidentialCandidate,
      parliamentary: parliamentaryCandidate,
      county: countyCandidate,
    );
    final algorithim = Ed25519();

    Digest digest = await hashVote(vote, keyPair);

    final signature = await algorithim.sign(digest.bytes, keyPair: keyPair);

    // // encode64 signature
    final sig64 = base64Encode(signature.bytes);

    vote.signature = sig64;
    vote.hash = digest.toString();
  }

  hashVote(Vote vote, SimpleKeyPair keyPair) async {
    final pubKey = await keyPair.extractPublicKey();

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    var _hash = "";

    final pub64 = base64Encode(pubKey.bytes);

    _hash += pub64; // Add address
    // Add candidates
    _hash += vote.presidential.name;
    _hash += vote.presidential.deputy;
    _hash += vote.parliamentary.name;
    _hash += vote.county.name;
    // Add timestamp
    _hash += timestamp;

    final bytes = utf8.encode(_hash); // convert hash to bytes
    final digest = sha512.convert(bytes); // produce digest

    return digest;
  }

  dispose() {
    _presidential.close();
    _parliamentary.close();
    _county.close();
    _keyPair.close();
  }
}
