import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBlocProvider.dart';
import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:jamiiclient/src/screens/voting/Ballot.dart';
import 'package:jamiiclient/src/screens/voting/Confirmation.dart';
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

                  // Ballots
                  StreamBuilder(
                    stream: bloc.presidential,
                    builder: (BuildContext context,
                        AsyncSnapshot<Candidate> candidateSnapshot) {
                      if (candidateSnapshot.hasData) {
                        return Ballot(
                            bloc: bloc,
                            pageController: pageController,
                            ballotType: "Presidential",
                            isPresidential: true,
                            candidates: extractPresidential(snapshot.data),
                            selectedCandidate: candidateSnapshot.data);
                      } else {
                        return Ballot(
                            bloc: bloc,
                            pageController: pageController,
                            ballotType: "Presidential",
                            isPresidential: true,
                            candidates: extractPresidential(snapshot.data),
                            selectedCandidate: Candidate());
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: bloc.parliamentary,
                    builder: (BuildContext context,
                        AsyncSnapshot<Candidate> candidateSnapshot) {
                      return Ballot(
                        bloc: bloc,
                        pageController: pageController,
                        ballotType: "Parliamentary",
                        isPresidential: false,
                        candidates: extractParliamentary(snapshot.data),
                        selectedCandidate: candidateSnapshot.hasData
                            ? candidateSnapshot.data
                            : Candidate(),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: bloc.county,
                    builder: (BuildContext context,
                        AsyncSnapshot<Candidate> candidateSnapshot) {
                      return Ballot(
                        bloc: bloc,
                        pageController: pageController,
                        ballotType: "County",
                        isPresidential: false,
                        candidates: extractCounty(snapshot.data),
                        selectedCandidate: candidateSnapshot.hasData
                            ? candidateSnapshot.data
                            : Candidate(),
                      );
                    },
                  ),
                  StreamBuilder(
                      stream: bloc.selectedCandidates,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Candidate>> snapshot) {
                        if (snapshot.hasData) {
                          return ConfirmationScreen(
                              candidates: snapshot.data,
                              pageController: pageController);
                        } else {
                          return ConfirmationScreen(
                            candidates: [],
                          );
                        }
                      })
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
