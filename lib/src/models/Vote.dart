import 'package:jamiiclient/src/models/Candidate.dart';

class Vote {
  Candidate presidential;
  Candidate parliamentary;
  Candidate county;
  String signature;
  String hash;

  Vote({
    this.presidential,
    this.parliamentary,
    this.county,
    this.signature,
    this.hash,
  });
}
