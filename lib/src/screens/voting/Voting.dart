import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/models/Candidate.dart';
import 'package:jamiiclient/src/screens/voting/Ballot.dart';
import 'package:jamiiclient/src/screens/voting/Intro.dart';

class VotingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    final List<Candidate> presidentialCandidates = [
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
    ];

    final List<Candidate> parliamentaryCandidates = [
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
    ];

    final List<Candidate> countyCandidates = [
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
      Candidate(
          name: "Edwin",
          deputy: "Walela",
          image: "",
          position: 1,
          isChecked: false),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: pageController,
          children: [
            Intro(pageController: pageController),
            Ballot(
              pageController: pageController,
              ballotType: "Presidential",
              isPresidential: true,
              candidates: presidentialCandidates,
            ),
            Ballot(
              pageController: pageController,
              ballotType: "Parliamentary",
              isPresidential: false,
              candidates: parliamentaryCandidates,
            ),
            Ballot(
              pageController: pageController,
              ballotType: "County Assembly Ward",
              isPresidential: false,
              candidates: countyCandidates,
            ),
          ],
        ),
      ),
    );
  }
}
