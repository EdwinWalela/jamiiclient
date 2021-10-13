import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/App.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final secureStorage = FlutterSecureStorage();
  final algorithim = Ed25519();

  final storedSeed = await secureStorage.read(key: "seed");

  var seed;

  if (storedSeed != null) {
    final readSeed = storedSeed.split(',');

    seed = readSeed.map(int.parse).toList();
  } else {
    // Create and store new seed
    final random = Random.secure();

    seed = List<int>.generate(32, (i) => random.nextInt(256));

    var seedString = seed.join(",");

    await secureStorage.write(key: "seed", value: seedString);
  }

  final keyPair = await algorithim.newKeyPairFromSeed(seed);

  final pubKey = await keyPair.extractPublicKey();
  // final privKey = await keyPair.extractPrivateKeyBytes();

  final pubKey64 = base64Encode(pubKey.bytes);
  // final privKey64 = base64Encode(privKey);

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

  // IO.Socket socket = IO.io('wss://93a8a7aee2d1.ngrok.io');

  // try {
  //   socket.onConnect((data) => {
  //         print("Connected to Node"),
  //         socket.emit("vote", json.encode(header)),
  //       });
  // } on Exception {
  //   print("error");
  // }
  // // Send vote
  // final channel = IOWebSocketChannel.connect("wss://93a8a7aee2d1.ngrok.io",
  //     headers: header);

  // // close channel
  // channel.sink.close();

  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final backCamera = cameras.first;
  final frontCamera = cameras.last;
  runApp(
    App(
      cameras: [backCamera, frontCamera],
      keyPair: keyPair,
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
