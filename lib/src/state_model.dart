import 'package:flutter/material.dart';

import 'ubermorgen.dart' show L, S;

// STATION 1:
class StateModel extends ChangeNotifier {
  bool station1TaskCompleted = false;
  bool station1Checked = false;
  String station1ImageFileName = "original.png";

  void reset() {
    // station 1:
    station1TaskCompleted = false;
    station1Checked = false;
    station1ImageFileName = "original.png";
    optionASelections = [false, false];
    optionBSelections = [false, false];
    optionCSelections = [false, false];

    // station 2:
    station2TaskCompleted = false;
    station2Checked = false;
    numberOfWindmills = 0;

    // station 3:
    station3TaskCompleted = false;
    station3CanBeMarkedDone = false;
    station3Checked = false;
    numberOfErrors = 5;
    items = [
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

    notifyListeners();
  }

  int _numberOfTasksToDo() {
    int n = 3;
    if (station1Checked) n--;
    if (station2Checked) n--;
    if (station3Checked) n--;
    return n;
  }

  Column introTextColumn() {
    int n = _numberOfTasksToDo();
    switch (n) {
      case 0:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schön, dass du bei „Dein Ort im Übermorgen“ mitgemacht hast!',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSizeHeader),
            ),
            SizedBox(height: 8),
            Text(
              'Um die Erderwärmung aufzuhalten, hast du an drei Stationen einen Beitrag für ein nachhaltiges Übermorgen geleistet.',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
            SizedBox(height: 8),
            Text(
              "Du hast alle Stationen bearbeitet. Prima!",
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
          ],
        );
      case 1:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schön, dass du bei „Dein Ort im Übermorgen“ dabei bist!',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSizeHeader),
            ),
            SizedBox(height: 8),
            Text(
              'Du kannst noch eine Station bearbeiten.',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
            SizedBox(height: 8),
            Text(
              "Bitte gehe mit deinem Team zu dieser Station und starte dann die Aufgabe.",
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
          ],
        );
      case 3:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Herzlich willkommen bei „Dein Ort im Übermorgen“!',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSizeHeader),
            ),
            SizedBox(height: 8),
            Text(
              'Um die Erderwärmung aufzuhalten, könnt ihr an drei Stationen (nicht linear) euren Beitrag für ein nachhaltiges Übermorgen leisten.',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
            SizedBox(height: 8),
            Text(
              "Bitte gehe mit deinem Team zu einer Station und starte die passende Aufgabe.",
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
          ],
        );
      default:
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schön, dass du bei „Dein Ort im Übermorgen“ dabei bist!',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSizeHeader),
            ),
            SizedBox(height: 8),
            Text(
              'Du kannst noch zwei Stationen bearbeiten.',
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
            SizedBox(height: 8),
            Text(
              "Bitte gehe mit deinem Team zu einer Station und starte die passende Aufgabe.",
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(fontSize: L.fontSize),
            ),
          ],
        );
    }
  }

  // Sation 1 stuff:

  void station1SetTaskCompleted() {
    station1TaskCompleted = true;
    notifyListeners();
  }

  void station1SetChecked(bool value, String imageFileName) {
    station1Checked = value;
    notifyListeners();
  }

  List<bool> optionASelections = [false, false];
  setOption1Selection(int index) {
    optionASelections = [false, false];
    optionASelections[index] = true;
    notifyListeners();
  }

  // Sation 2 stuff:

  List<bool> optionBSelections = [false, false];
  setOption2Selection(int index) {
    optionBSelections = [false, false];
    optionBSelections[index] = true;
    notifyListeners();
  }

  List<bool> optionCSelections = [false, false];
  setOption3Selection(int index) {
    optionCSelections = [false, false];
    optionCSelections[index] = true;
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
    return optionASelections.contains(true) &&
        optionBSelections.contains(true) &&
        optionCSelections.contains(true);
  }

  String makeImageNameFromOptions() {
    return (optionASelections[0] ? "1A" : "1B") +
        (optionBSelections[0] ? "2A" : "2B") +
        (optionCSelections[0] ? "3A" : "3B");
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

  List<List> items = [
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
