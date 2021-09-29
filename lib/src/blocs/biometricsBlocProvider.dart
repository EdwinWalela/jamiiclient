import 'package:flutter/material.dart';
import 'package:jamiiclient/src/blocs/BiometricsBloc.dart';

class BiometricsProvider extends InheritedWidget {
  BiometricsProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;
  final bloc = BiometricsBloc();

  static BiometricsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BiometricsProvider>())
        .bloc;
  }
}
