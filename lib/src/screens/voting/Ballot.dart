import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ballot extends StatelessWidget {
  final PageController pageController;
  final bool isPresidential;
  final String ballotType;
  final List<String> candidates = <String>[
    'a',
    'a',
    'a',
    'a',
    'a',
  ];
  Ballot({this.pageController, this.isPresidential, this.ballotType});

  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(this.ballotType),
        Expanded(
          child: ListView.builder(
            itemCount: candidates.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCard(this.isPresidential);
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

  Widget buildCard(bool isPresidential) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.person,
              size: 50,
            ),
            trailing: Icon(
              Icons.check_box_outline_blank,
              size: 50,
            ),
            title: Text('Candidate Name'),
            subtitle: isPresidential ? Text('Deputy') : null,
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
    String buttonText,
    PageController pageController,
  ) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () {},
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
