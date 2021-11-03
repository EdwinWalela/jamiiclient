import 'package:flutter/material.dart';

class Ballot extends StatelessWidget {
  final PageController pageController;
  final List<String> candidates = <String>[
    'a',
  ];
  Ballot({this.pageController});

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Header",
        ),
        Expanded(
          child: ListView.builder(
            itemCount: candidates.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCard();
            },
          ),
        )
      ],
    );
  }

  Widget buildCard() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
