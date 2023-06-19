import 'package:flutter/material.dart';

// STATION 1:
class StateModel extends ChangeNotifier {
  bool station1TaskCompleted = false;
  bool station1Checked = false;
  String station1ImageFileName = "original.png";

  void station1SetTaskCompleted() {
    station1TaskCompleted = true;
    notifyListeners();
  }

  void station1SetChecked(bool value, String imageFileName) {
    station1Checked = value;
    notifyListeners();
  }

  List<bool> option1Selections = [false, false];
  setOption1Selection(int index) {
    option1Selections = [false, false];
    option1Selections[index] = true;
    notifyListeners();
  }

  List<bool> option2Selections = [false, false];
  setOption2Selection(int index) {
    option2Selections = [false, false];
    option2Selections[index] = true;
    notifyListeners();
  }

  List<bool> option3Selections = [false, false];
  setOption3Selection(int index) {
    option3Selections = [false, false];
    option3Selections[index] = true;
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

  bool canCheckInTask() {
    return option1Selections.contains(true) &&
        option2Selections.contains(true) &&
        option3Selections.contains(true);
  }

  String makeImageNameFromOptions() {
    return (option1Selections[0] ? "1A" : "1B") +
        (option2Selections[0] ? "2A" : "2B") +
        (option3Selections[0] ? "3A" : "3B");
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
    // Title, Color, Icon path, Correct rank
    [
      'Bananen (Südfrüchte)',
      const Color.fromARGB(255, 240, 233, 39),
      'banana.png',
      2,
    ],
    [
      'Blumen',
      const Color.fromARGB(255, 195, 65, 166),
      'flowers.png',
      4,
    ],
    [
      'Kaffee',
      const Color.fromARGB(255, 123, 74, 31),
      'coffee.png',
      0,
    ],
    [
      'Kakao',
      const Color.fromARGB(255, 160, 125, 93),
      'cocoa.png',
      1,
    ],
    [
      'Textilien',
      const Color.fromARGB(255, 170, 184, 201),
      'textiles.png',
      3,
    ],
  ];

  int numberOfErrors = 5;

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
    numberOfErrors = 0;
    for (var it in items) {
      if (items.indexOf(it) != it[3]) {
        numberOfErrors = numberOfErrors + 1;
      }
    }
    notifyListeners();
  }
}
