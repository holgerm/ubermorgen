import 'package:flutter/material.dart';

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
  bool station3Checked = false;

  final List<List> items = [
    ['Kaffee', const Color.fromARGB(255, 98, 50, 9)],
    ['Kakao', const Color.fromARGB(255, 160, 125, 93)],
    ['Blumen', const Color.fromARGB(255, 195, 65, 166)],
    ['Textilien', const Color.fromARGB(255, 170, 184, 201)],
    ['Bananen (Südfrüchte)', const Color.fromARGB(255, 240, 233, 39)]
  ];

  removeItemAt(int oldIndex) {
    var result = items.removeAt(oldIndex);
    notifyListeners();
    return result;
  }

  void insert(int newIndex, var item) {
    items.insert(newIndex, item);
    notifyListeners();
  }

  void station3SetTaskCompleted() {
    station3TaskCompleted = true;
    notifyListeners();
  }

  void station3SetCanBeMarkedAsDone(bool value) {
    station3CanBeMarkedDone = value;
    notifyListeners();
  }

  void station3SetChecked(bool value) {
    station3Checked = value;
    notifyListeners();
  }
}
