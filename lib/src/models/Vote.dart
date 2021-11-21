import 'package:jamiiclient/src/models/Candidate.dart';

class Vote {
  Candidate presidential;
  Candidate parliamentary;
  Candidate county;
  String signature;
  String hash;
  String pubKey64;
  String timestamp;

  Vote({
    this.presidential,
    this.parliamentary,
    this.county,
    this.signature,
    this.hash,
    this.pubKey64,
    this.timestamp,
  });

  @override
  String toString() {
    // final data = "$digest|$sig64|$pub64|$pub64.$pub64.$pub64.$pub64|$timestamp";
    final presidential = '${this.presidential.name}';
    final parliamentary = '${this.parliamentary.name}';
    final county = '${this.county.name}';

    return "${this.hash}|${this.signature}|${this.pubKey64}|$presidential|$parliamentary|$county|${this.timestamp}";
  }
}
