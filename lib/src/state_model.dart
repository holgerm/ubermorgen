import 'package:flutter/material.dart';

import 'ubermorgen.dart';

class StateModel extends ChangeNotifier {
  var points = {
    S.keyStation1: {
      S.keyDone: false,
    },
    S.keyStation2: {
      S.keyDone: false,
    },
    S.keyStation3: {
      S.keyDone: false,
    },
  };
  bool station2TaskCompleted = false;
  bool station2CanBeMarkedDone = false;

  int numberOfWindmills = 0;

  void markAsDone(String station) {
    if (points[station] == null) {
      return;
    }
    if (points[station]![S.keyDone] == false) {
      points[station]![S.keyDone] = true;
      notifyListeners();
    }
  }

  void station2SetWindmillDone(int newNumber) {
    numberOfWindmills = newNumber;
    notifyListeners();
  }

  void station2SetCanBeMarkedAsDone(bool value) {
    station2CanBeMarkedDone = value;
    notifyListeners();
  }

  void station2SetTaskCompleted() {
    station2TaskCompleted = true;
    notifyListeners();
  }

  String station2GetNumberOfWindmillsText() {
    if (numberOfWindmills == 0) {
      return "Ich habe noch keine Windräder gebaut.";
    } else if (numberOfWindmills == 1) {
      return "Ich habe ein Windrad gebaut.";
    } else {
      return "Ich habe $numberOfWindmills Windräder gebaut";
    }
  }
}
