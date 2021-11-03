import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/voting/Ballot.dart';
import 'package:jamiiclient/src/screens/voting/Intro.dart';

class VotingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

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
            ),
            Ballot(
              pageController: pageController,
              ballotType: "Parliamentary",
              isPresidential: false,
            ),
            Ballot(
              pageController: pageController,
              ballotType: "County Assembly Ward",
              isPresidential: false,
            ),
          ],
        ),
      ),
    );
  }
}
