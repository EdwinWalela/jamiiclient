import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketProvider {
  void mockRegistration() {
    print("mocking");
    final header = {
      "source": "client",
      "type": "0",
      "data":
          "b5300a79468cf8cac475a0fd892a65339e3b90c4755d77b643a38b75d2820b3c2c6884466c37c60de3deb05cba9798ed07646cb81b268fe98bdb0286de4bbffc"
    };
    IO.Socket socket = IO.io('wss://85dc-197-237-160-234.ngrok.io');

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("register", json.encode(header)),
        });
  }

  registerVoter(String details) async {
    final data = details;
    var res = 0;
    var isValid = false;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Connect to node
    IO.Socket socket = IO.io('wss://85dc-197-237-160-234.ngrok.io');

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("register", json.encode(header)),
        });
  }

  Future<bool> sendVote(String vote) async {
    final data = vote;
    var res = 0;
    var isValid = false;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Send vote

    // Connect to node
    IO.Socket socket = IO.io('wss://b191-197-237-160-234.ngrok.io');

    // final sock = await Socket.connect('b191-197-237-160-234.ngrok.io', 80);
    // sock.add(utf8.encode(json.encode(header)));
    // final res = await sock.first;
    // final decodedRes = String.fromCharCodes(res);
    // print(decodedRes);
    // sock.close();
    while (res != 1) {
      print(".");
      socket.onConnect(
        (data) => {
          print("Connected to Node"),
          socket.emit("vote", json.encode(header)),
          socket.on(
            "VOTE_ACK",
            (data) {
              isValid = true;
              res = 1;
            },
          ),
          socket.on(
            "VOTE_INV",
            (data) {
              isValid = false;
              res = 1;
            },
          )
        },
      );
    }
    return isValid;
  }
}
