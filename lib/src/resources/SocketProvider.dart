import 'dart:io';

import 'package:jamiiclient/src/resources/DBProvider.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketProvider {
  final uri = "wss://8fb0-105-163-2-63.ngrok.io";

  void mockRegistration(String details) {
    Repository repo = Repository();
    print("mocking registration");
    final header = {
      "source": "client",
      "type": "0",
      "data": details,
    };
    final hash = details.split("|")[0];

    IO.Socket socket = IO.io(
      uri,
    );

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("register", json.encode(header)),
          socket.on(
            "VOTE_ACK",
            (data) async => {
              repo.addHash(hash),
            },
          )
        });
  }

  registerVoter(String details) async {
    final data = details;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Connect to node
    IO.Socket socket = IO.io(uri);

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("register", json.encode(header)),
        });

    socket.disconnect();
  }

  void mockVote() {
    print("mocking vote");
    final data =
        "67e87f6ea0f0d0a71abaaed4b41c2acebfc1076f1c5e490d2e9480426046a486c4fb9a3d5ec56d8f697fb910fe2998ee80a53ddf741a4a7c5643b7e735cd30aa|rLcSZMLSQq+5gHxATwVx/leukV+fD/jfidMRJOxu4Fd6k74hV2bMj5f1U/ObCtsXeVIPlrcbpj1P0cSn7kLYCQ==|sZU3PmAC+auyhzXKvT4x/8k3G5ZE3Znw1+qI900nnH4=|Edwin4.Edwin7.Edwinc4|1641562683605";
    var res = 0;
    var isValid = false;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Connect to node
    IO.Socket socket = IO.io(uri);

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("vote", json.encode(header)),
          socket.disconnect()
        });
  }

  Future<bool> sendVote(String vote) async {
    final data = vote;
    var res = 0;
    var isValid = true;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };
    print(header);
    // Send vote

    // Connect to node
    IO.Socket socket = IO.io(uri);

    // final sock = await Socket.connect('b191-197-237-160-234.ngrok.io', 80);
    // sock.add(utf8.encode(json.encode(header)));
    // final res = await sock.first;
    // final decodedRes = String.fromCharCodes(res);
    // print(decodedRes);
    // sock.close();

    return isValid;
  }
}
