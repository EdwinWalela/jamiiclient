import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BallotBloc.dart';

class BallotBlocProvider extends InheritedWidget {
  BallotBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;
  final bloc = BallotBloc();

  static BallotBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BallotBlocProvider>())
        .bloc;
  }
}
