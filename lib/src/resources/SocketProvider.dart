import 'package:web_socket_channel/io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class SocketProvider {
  Future<String> sendVote(String vote) async {
    final data = vote;
    final header = {
      "source": "client",
      "type": "0", // vote submission
      "data": "$data",
    };

    // Connect to node
    IO.Socket socket = IO.io('wss://af09-197-237-160-234.ngrok.io');

    try {
      socket.onConnect((data) => {
            print("Connected to Node"),
            socket.emit("vote", json.encode(header)),
          });
    } on Exception {
      print("error");
    }
    // Send vote
    final channel = IOWebSocketChannel.connect(
        "wss://af09-197-237-160-234.ngrok.io",
        headers: header);

    // close channel
    channel.sink.close();

    final res = await channel.stream.first;
    return res;
  }
}
