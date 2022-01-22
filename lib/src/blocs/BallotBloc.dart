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
  final _results = BehaviorSubject<String>();

  Function(Candidate) get addPresidential => _presidential.sink.add;
  Function(Candidate) get addParliamentary => _parliamentary.sink.add;
  Function(Candidate) get addCounty => _county.sink.add;
  Function(SimpleKeyPair) get addKeyPair => _keyPair.sink.add;
  Function(List<Candidate>) get addCandidates => _electionCandidates.sink.add;
  Function(String) get addResults => _results.sink.add;

  Stream<Candidate> get presidential => _presidential.stream;
  Stream<Candidate> get parliamentary => _parliamentary.stream;
  Stream<Candidate> get county => _county.stream;
  Stream<List<Candidate>> get electionCandidates => _electionCandidates.stream;

  Stream<List<Candidate>> get selectedCandidates =>
      CombineLatestStream.list([_presidential, _parliamentary, _county]);
  Stream<String> get results => _results.stream;

  addData() {
    final List<Candidate> presidentialCandidates = [
      Candidate(
          name: "Presidential Candidate 1",
          deputy: "PC Deputy 1",
          image: "assets/images/mango.jpg",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Presidential Candidate 2",
          deputy: "PC Deputy 2",
          image: "assets/images/strawberry.jpg",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Presidential Candidate 3",
          deputy: "PC Deputy 3",
          image: "assets/images/banana.jpg",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Presidential Candidate 4",
          deputy: "PC Deputy 4",
          image: "assets/images/apple.png",
          position: 1,
          isChecked: false),
    ];

    final List<Candidate> parliamentaryCandidates = [
      Candidate(
          name: "Parliamentary Candidate 1",
          deputy: "Deputy 1",
          image: "assets/images/apple.png",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Parliamentary Candidate 2",
          deputy: "Deputy 2",
          image: "assets/images/banana.jpg",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Parliamentary Candidate 3",
          deputy: "Deputy 3",
          image: "assets/images/mango.jpg",
          position: 2,
          isChecked: false),
      Candidate(
          name: "Parliamentary Candidate 4",
          deputy: "Deputy 4",
          image: "assets/images/strawberry.jpg",
          position: 2,
          isChecked: false),
    ];

    final List<Candidate> countyCandidates = [
      Candidate(
          name: "County Candidate 1",
          deputy: "Walela",
          image: "assets/images/strawberry.jpg",
          position: 3,
          isChecked: false),
      Candidate(
          name: "County Candidate 2",
          deputy: "Walela",
          image: "assets/images/banana.jpg",
          position: 3,
          isChecked: false),
      Candidate(
          name: "County Candidate 3",
          deputy: "Walela",
          image: "assets/images/apple.png",
          position: 3,
          isChecked: false),
      Candidate(
          name: "County Candidate 4",
          deputy: "Walela",
          image: "assets/images/mango.jpg",
          position: 3,
          isChecked: false),
    ];

    List<Candidate> candidates = [];

    candidates.addAll(presidentialCandidates);
    candidates.addAll(parliamentaryCandidates);
    candidates.addAll(countyCandidates);

    addCandidates(candidates);
  }

  mockVote() {
    _repository.mockVote();
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

  queryRes() async {
    _repository.queryResults();
  }

  retriveResults() async {
    final result = await _repository.retrieveResult();

    if (result.length > 0) {
      addResults(result[0]['result']);
    } else {
      print("No results");
      _results.sink.addError("no results");
    }
  }

  dispose() {
    _presidential.close();
    _parliamentary.close();
    _county.close();
    _electionCandidates.close();
    _keyPair.close();
    _results.close();
  }
}
