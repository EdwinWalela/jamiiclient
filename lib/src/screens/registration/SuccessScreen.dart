import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBlocProvider.dart';
import 'package:jamiiclient/src/blocs/BiometricsBloc.dart';
import 'package:jamiiclient/src/screens/voting/Voting.dart';

class SuccessScreen extends StatelessWidget {
  final BiometricsBloc biometricsBloc;

  SuccessScreen({this.biometricsBloc});

  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 13), () {
      this.biometricsBloc.retriveHash();
    });

    return StreamBuilder(
      stream: biometricsBloc.regHash,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          Navigator.of(context).pushNamed('/vote');
          // _redirect(context, BallotBlocProvider(child: VotingScreen()));
          return Container();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSuccessIcon(context),
              Container(margin: EdgeInsets.only(top: 30)),
              buildTitle(),
              Container(margin: EdgeInsets.only(top: 10)),
              buildSubTitle(),
            ],
          );
        }
      },
    );
  }

  Widget buildTitle() {
    return Text(
      "Details submitted for verification",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildSubTitle() {
    return Text(
      "Process might take a while",
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

  void _redirect(BuildContext context, Widget screen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => screen);
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/register'));
    });
  }
}
