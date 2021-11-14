import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBloc.dart';
import 'package:jamiiclient/src/blocs/BallotBlocProvider.dart';
import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:jamiiclient/src/screens/voting/Ballot.dart';
import 'package:jamiiclient/src/screens/voting/Intro.dart';

class VotingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = BallotBlocProvider.of(context);
    // Hard coded data
    bloc.addData();

    final PageController pageController = PageController(initialPage: 1);

    return Scaffold(
      body: StreamBuilder(
        stream: bloc.electionCandidates,
        builder:
            (BuildContext context, AsyncSnapshot<List<Candidate>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: pageController,
                children: [
                  Intro(pageController: pageController),
                  Ballot(
                    bloc: bloc,
                    pageController: pageController,
                    ballotType: "Presidential",
                    isPresidential: true,
                    candidates: extractPresidential(snapshot.data),
                  ),
                  Ballot(
                    bloc: bloc,
                    pageController: pageController,
                    ballotType: "Parliamentary",
                    isPresidential: false,
                    candidates: extractParliamentary(snapshot.data),
                  ),
                  Ballot(
                    bloc: bloc,
                    pageController: pageController,
                    ballotType: "County Assembly Ward",
                    isPresidential: false,
                    candidates: extractCounty(snapshot.data),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  List<Candidate> extractPresidential(List<Candidate> candidates) {
    List<Candidate> extracted = [];
    for (Candidate candidate in candidates) {
      if (candidate.position == 1) {
        extracted.add(candidate);
      }
    }
    return extracted;
  }

  List<Candidate> extractParliamentary(List<Candidate> candidates) {
    List<Candidate> extracted = [];
    for (Candidate candidate in candidates) {
      if (candidate.position == 2) {
        extracted.add(candidate);
      }
    }
    return extracted;
  }

  List<Candidate> extractCounty(List<Candidate> candidates) {
    List<Candidate> extracted = [];
    for (Candidate candidate in candidates) {
      if (candidate.position == 3) {
        extracted.add(candidate);
      }
    }
    return extracted;
  }
}
