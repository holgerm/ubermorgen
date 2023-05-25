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

  void markAsDone(String station) {
    if (points[station] == null) {
      return;
    }
    if (points[station]![S.keyDone] == false) {
      points[station]![S.keyDone] = true;
      notifyListeners();
    }
  }
}
