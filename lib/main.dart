import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/App.dart';
import 'package:jamiiclient/src/blocs/BallotBlocProvider.dart';
import 'package:jamiiclient/src/resources/DBProvider.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:camera/camera.dart';

getPeer() async {
  final res =
      await http.get(Uri.parse("https://jamii-peer.herokuapp.com/peers"));
  final resObj = jsonDecode(res.body);
  var url = resObj["peers"][0];

  url = url.replaceAll("http", "wss");
  return url;
}

void main() async {
  // nodeUrl.replaceAll(nodeUrl, replace)

  final nodeUrl = await getPeer();

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

  HttpOverrides.global = new MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final backCamera = cameras.first;
  final frontCamera = cameras.last;
  runApp(
    BallotBlocProvider(
      child: App(
        cameras: [backCamera, frontCamera],
        keyPair: keyPair,
        nodeUrl: nodeUrl,
      ),
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
