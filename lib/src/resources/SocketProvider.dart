import 'dart:io';

import 'package:jamiiclient/src/resources/DBProvider.dart';
import 'package:jamiiclient/src/resources/repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketProvider {
  final uri = "wss://852b-41-90-70-248.ngrok.io";

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

  registerVoter(String details, String nodeUrl) async {
    print("registering voter");
    Repository repo = Repository();
    final data = details;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Connect to node
    IO.Socket socket = IO.io(nodeUrl);

    final hash = details.split("|")[0];

    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("register", json.encode(header)),
          socket.on(
            "VOTE_ACK",
            (data) async => {
              await repo.addHash(hash),
              socket.disconnect(),
            },
          )
        });
    await Future.delayed(const Duration(seconds: 10), () {
      socket.disconnect();
      socket.close();
      socket.close();
      socket = null;
      print("Socket disconnected");
    });
  }

  void mockVote() {
    print("mocking vote");
    final data =
        "67e87f6ea0f0d0a71abaaed4b41c2acebfc1076f1c5e490d2e9480426046a486c4fb9a3d5ec56d8f697fb910fe2998ee80a53ddf741a4a7c5643b7e735cd30aa|rLcSZMLSQq+5gHxATwVx/leukV+fD/jfidMRJOxu4Fd6k74hV2bMj5f1U/ObCtsXeVIPlrcbpj1P0cSn7kLYCQ==|sZU3PmAC+auyhzXKvT4x/8k3G5ZE3Znw1+qI900nnH4=|PresidentialCandidate1.ParliamentaryCandidate3.CountyCandidate2|1641562683605";
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

  Future<bool> sendVote(String vote, String nodeUrl) async {
    final data = vote;
    var res = 0;
    var isValid = true;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };
    // Send vote
    print("sending vote");
    // Connect to node
    IO.Socket socket = IO.io(
      nodeUrl,
      IO.OptionBuilder().enableForceNew().build(),
    );
    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("vote", json.encode(header)),
        });
    socket.onConnectError((data) => {print("con-error")});
    socket.onError((data) => {print("error")});
    await Future.delayed(const Duration(seconds: 10), () {});
    await Future.delayed(const Duration(seconds: 0), () {
      socket.disconnect();
      socket.close();
      socket.close();
      socket = null;
      print("Socket disconnected");
    });
    return isValid;
  }

  queryResult(String nodeUrl) async {
    await Future.delayed(const Duration(seconds: 20), () {});
    Repository repo = Repository();
    var data = "";

    print("connecting to node");
    // Connect to node
    IO.Socket socket = IO.io(
      nodeUrl,
      IO.OptionBuilder().enableForceNew().build(),
    );
    socket.onConnect((data) => {
          print("Connected to Node"),
          socket.emit("req", ""),
          socket.on("result", (res) async {
            await repo.addResults(res);
          })
        });

    await Future.delayed(const Duration(seconds: 20), () {});
    await Future.delayed(const Duration(seconds: 10), () {
      socket.disconnect();
      socket.close();
      socket.close();
      socket = null;
      print("Socket disconnected");
    });
  }
}
