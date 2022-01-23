import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBloc.dart';

class SuccessScreen extends StatelessWidget {
  final BallotBloc bloc;
  final String nodeUrl;

  SuccessScreen({
    this.bloc,
    this.nodeUrl,
  });

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.results,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            final list = snapshot.data.split("|");
            return ListView.builder(
                itemCount: list.length - 1,
                itemBuilder: (BuildContext context, int index) {
                  final category = list[index].split("-");
                  print(category);
                  return Row(
                    children: [
                      Text(category[0]),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Text(category[1] + " votes"),
                    ],
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSuccessIcon(context),
                Container(margin: EdgeInsets.only(top: 30)),
                buildTitle(),
                Container(margin: EdgeInsets.only(top: 10)),
                buildSubTitle(),
                buildButton(),
              ],
            );
          }
        });
  }

  Widget buildTitle() {
    return Text(
      "Your vote has been cast",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildButton() {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () async {
          await bloc.retriveResults();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("View Results"),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.purple,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubTitle() {
    return Text(
      "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey[700],
      ),
    );
  }

  Widget buildSuccessIcon(BuildContext context) {
    return Icon(
      Icons.check_circle_outline_rounded,
      size: 100,
    );
  }
}
