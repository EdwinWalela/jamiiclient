import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/App.dart';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  // final algorithim = Ed25519();
  // final keyPair = await algorithim.newKeyPair();
  // final pubKey = await keyPair.extractPublicKey();
  // final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  // var _hash = "";

  // final pub64 = base64Encode(pubKey.bytes);

  // _hash += pub64; // Add address
  // _hash += pub64 + pub64 + pub64 + pub64; // Add candidates
  // _hash += timestamp; // Add timestamp

  // final bytes = utf8.encode(_hash); // convert hash to bytes
  // final digest = sha512.convert(bytes); // produce digest

  // // sign hash
  // final signature = await algorithim.sign(digest.bytes, keyPair: keyPair);

  // // encode64 signature
  // final sig64 = base64Encode(signature.bytes);

  // final data = "$digest|$sig64|$pub64|$pub64.$pub64.$pub64.$pub64|$timestamp";
  // final header = {
  //   "source": "client",
  //   "type": "0", // vote submission
  //   "data": "$data",
  // };

  // IO.Socket socket = IO.io('wss://091d1f7f7171.ngrok.io');

  // try {
  //   socket.onConnect((data) => {
  //         print("Connected to Node"),
  //         socket.emit("vote", json.encode(header)),
  //       });
  // } on Exception {
  //   print("error");
  // }
  // Send vote
  // final channel = IOWebSocketChannel.connect("wss://bde039a33cea.ngrok.io",
  //     headers: header);

  // // close channel
  // channel.sink.close();
  runApp(App());
}
