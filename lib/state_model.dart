import 'package:flutter/material.dart';

class StateModel extends ChangeNotifier {
  var points = {
    'station1': {
      'done': false,
    },
    'station2': {
      'done': false,
    },
    'station3': {
      'done': false,
    },
  };

  void markAsDone(String station) {
    if (points[station] == null) {
      return;
    }
    if (points[station]!['done'] == false) {
      points[station]!['done'] = true;
      notifyListeners();
    }
  }
}
