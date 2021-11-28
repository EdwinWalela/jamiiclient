import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:jamiiclient/src/models/Vote.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class BallotBloc {
  final _repository = Repository();
  final _presidential = BehaviorSubject<Candidate>();
  final _parliamentary = BehaviorSubject<Candidate>();
  final _county = BehaviorSubject<Candidate>();
  final _keyPair = BehaviorSubject<SimpleKeyPair>();
  final _electionCandidates = BehaviorSubject<List<Candidate>>();

  Function(Candidate) get addPresidential => _presidential.sink.add;
  Function(Candidate) get addParliamentary => _parliamentary.sink.add;
  Function(Candidate) get addCounty => _county.sink.add;
  Function(SimpleKeyPair) get addKeyPair => _keyPair.sink.add;
  Function(List<Candidate>) get addCandidates => _electionCandidates.sink.add;

  Stream<Candidate> get presidential => _presidential.stream;
  Stream<Candidate> get parliamentary => _parliamentary.stream;
  Stream<Candidate> get county => _county.stream;
  Stream<List<Candidate>> get electionCandidates => _electionCandidates.stream;

  Stream<List<Candidate>> get selectedCandidates =>
      CombineLatestStream.list([_presidential, _parliamentary, _county]);

  addData() {
    final List<Candidate> presidentialCandidates = [
      Candidate(
          name: "Edwin1",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin2",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin3",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin4",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
    ];

    final List<Candidate> parliamentaryCandidates = [
      Candidate(
          name: "Edwin9",
          deputy: "Walela",
          image: "",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Edwin8",
          deputy: "Walela",
          image: "",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Edwin7",
          deputy: "Walela",
          image: "",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Edwin6",
          deputy: "Walela",
          image: "",
          position: 2,
          isChecked: false),
    ];

    final List<Candidate> countyCandidates = [
      Candidate(
          name: "Edwinc1",
          deputy: "Walela",
          image: "",
          position: 3,
          isChecked: false),
      Candidate(
          name: "Edwinc2",
          deputy: "Walela",
          image: "",
          position: 3,
          isChecked: false),
      Candidate(
          name: "Edwinc3",
          deputy: "Walela",
          image: "",
          position: 3,
          isChecked: false),
      Candidate(
          name: "Edwinc4",
          deputy: "Walela",
          image: "",
          position: 3,
          isChecked: false),
    ];

    List<Candidate> candidates = [];

    candidates.addAll(presidentialCandidates);
    candidates.addAll(parliamentaryCandidates);
    candidates.addAll(countyCandidates);

    addCandidates(candidates);
  }

  submit() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

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

    Digest digest = await hashVote(vote, keyPair, timestamp);

    final digestBytes = utf8.encode(digest.toString());
    final signature = await algorithim.sign(digestBytes, keyPair: keyPair);

    // // encode64 signature
    final sig64 = base64Encode(signature.bytes);

    final pubKey = await keyPair.extractPublicKey();
    final pub64 = base64Encode(pubKey.bytes);

    vote.signature = sig64;
    vote.hash = digest.toString();

    vote.pubKey64 = pub64;
    vote.timestamp = timestamp;

    final res = await _repository.sendVote(vote.toString());

    print("\n");
    print(res);
  }

  hashVote(Vote vote, SimpleKeyPair keyPair, String timestamp) async {
    final pubKey = await keyPair.extractPublicKey();

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
    _electionCandidates.close();
    _keyPair.close();
  }
}
