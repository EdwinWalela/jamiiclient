import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBloc.dart';
import 'package:jamiiclient/src/models/Candidate.dart';

class ConfirmationScreen extends StatelessWidget {
  final List<Candidate> candidates;
  final PageController pageController;
  final BallotBloc bloc;

  ConfirmationScreen({this.candidates, this.pageController, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: this.candidates.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCard(
                this.candidates[index].position == 1,
                this.candidates[index],
              );
            },
          ),
        ),
        buildButton("Cast Vote", this.pageController, this.bloc)
      ],
    );
  }

  Widget buildHeader() {
    return Text(
      "Confirm Selection",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildCard(bool isPresidential, Candidate candidate) {
    return Card(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              candidate.image,
              width: 80,
              height: 80,
            ),
            title: Text(candidate.name),
            subtitle: isPresidential ? Text(candidate.deputy) : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      String buttonText, PageController pageController, BallotBloc bloc) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () async {
          await pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          bloc.submit();
          Future.delayed(const Duration(seconds: 15), () {
            bloc.queryRes();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText),
            Container(
              margin: EdgeInsets.only(right: 5),
            ),
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
}
