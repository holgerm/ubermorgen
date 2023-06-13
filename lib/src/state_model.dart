import 'package:flutter/material.dart';
import 'ubermorgen.dart';

// STATION 1:
class StateModel extends ChangeNotifier {
  bool station1TaskCompleted = false;
  bool station1Checked = false;

  void station1SetTaskCompleted() {
    station1TaskCompleted = true;
    notifyListeners();
  }

  void station1SetChecked(bool value) {
    station1Checked = value;
    notifyListeners();
  }

  // STATION 2:

  bool station2TaskCompleted = false;
  bool station2Checked = false;
  int numberOfWindmills = 0;

  void station2SetTaskCompleted() {
    station2TaskCompleted = true;
    notifyListeners();
  }

  void station2SetChecked(bool value) {
    station2Checked = value;
    notifyListeners();
  }

  void station2SetNumberOfWindmillsBuilt(int newNumber) {
    numberOfWindmills = newNumber;
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

  // STATION 3:

  bool station3TaskCompleted = false;
  bool station3CanBeMarkedDone = false;

  void station3SetTaskCompleted() {
    station3TaskCompleted = true;
    notifyListeners();
  }

  void station3SetCanBeMarkedAsDone(bool value) {
    station3CanBeMarkedDone = value;
    notifyListeners();
  }
}
