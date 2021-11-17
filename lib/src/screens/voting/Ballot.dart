import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBloc.dart';
import 'package:jamiiclient/src/models/Candidate.dart';

class Ballot extends StatelessWidget {
  final PageController pageController;
  final bool isPresidential;
  final String ballotType;
  final List<Candidate> candidates;
  final BallotBloc bloc;
  final Candidate selectedCandidate;

  Ballot({
    this.pageController,
    this.isPresidential,
    this.ballotType,
    this.candidates,
    this.bloc,
    this.selectedCandidate,
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(this.ballotType),
        Expanded(
          child: ListView.builder(
            itemCount: this.candidates.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCard(
                this.isPresidential,
                this.candidates[index],
                this.bloc,
                this.ballotType,
                this.selectedCandidate,
              );
            },
          ),
        ),
        buildButton("Next", this.pageController)
      ],
    );
  }

  Widget buildHeader(String ballotType) {
    return Text(
      "$ballotType Ballot",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildCard(bool isPresidential, Candidate candidate, BallotBloc bloc,
      String ballotType, Candidate selectedCandidate) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            trailing: buildCheckBox(
              candidate,
              bloc,
              ballotType,
              selectedCandidate,
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

  Widget buildCheckBox(Candidate candidate, BallotBloc bloc, String ballotType,
      Candidate selectedCandidate) {
    // print(selectedCandidate.name);
    // print(candidate.name);
    return InkWell(
      onTap: () {
        // Change state
        switch (ballotType) {
          case "Presidential":
            bloc.addPresidential(candidate);
            break;
          case "Parliamentary":
            bloc.addParliamentary(candidate);
            break;
          case "County":
            bloc.addCounty(candidate);
        }
      },
      child: candidate.name != selectedCandidate.name
          ? Icon(Icons.check_box_outline_blank)
          : Icon(Icons.check_box_outlined),
    );
  }

  Widget buildButton(String buttonText, PageController pageController) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () async {
          await pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
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
