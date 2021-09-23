import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamiiclient/src/screens/onboarding/InfoScreen.dart';

class OnBoardingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          InfoScreen(
            index: 1,
            title: "Welcome to Jamii",
            description: "A transparent and secure way to vote",
            buttonText: "Next",
            iconFile: "assets/gif/community.gif",
            svgTop: false,
            pageController: pageController,
          ),
          InfoScreen(
            index: 2,
            title: "Transparent Yet Confidential",
            description:
                "Your vote is cryptographically secured and sent to a private pee-to-peer network to be validated by the jamii",
            buttonText: "Next",
            svgTop: true,
            iconFile: "assets/gif/Vault.gif",
            pageController: pageController,
          ),
          InfoScreen(
            index: 3,
            title: "Vote Anywhere",
            description:
                "Register for elections and cast your vote from anywhere using your mobile phone",
            buttonText: "Next",
            svgTop: false,
            iconFile: "assets/gif/relax.gif",
            pageController: pageController,
          ),
          InfoScreen(
            index: 4,
            title: "Immutable",
            description:
                "Votes are secured using cryptography making it infeasible to be altered",
            buttonText: "Next",
            svgTop: true,
            iconFile: "assets/gif/laptop.gif",
            pageController: pageController,
          ),
          InfoScreen(
            index: 5,
            title: "Voting Decentralized",
            description: "Time to take control",
            buttonText: "Get Started",
            svgTop: false,
            iconFile: "assets/gif/high-five.gif",
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}
