import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ubermorgen.dart' show L, S, StateModel;

class StationOne extends StatefulWidget {
  const StationOne({super.key});

  @override
  State<StationOne> createState() => _StationOneState();
}

class _StationOneState extends State<StationOne> {
  List<bool> option1Selections = [false, false];
  _setOption1Selection(int index) {
    setState(
      () {
        option1Selections = [false, false];
        option1Selections[index] = true;
      },
    );
  }

  List<bool> option2Selections = [false, false];
  _setOption2Selection(int index) {
    setState(
      () {
        option2Selections = [false, false];
        option2Selections[index] = true;
      },
    );
  }

  List<bool> option3Selections = [false, false];
  _setOption3Selection(int index) {
    setState(
      () {
        option3Selections = [false, false];
        option3Selections[index] = true;
      },
    );
  }

  _makeToggleButtonsFor(
      String description,
      final String optionA,
      final String optionB,
      Function(int) setOptionMethod,
      List<bool> optionSelections) {
    return Flexible(
      flex: (L.heightOfContent / 3.0).round(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            child: Text(description),
          ),
          Container(
            padding: const EdgeInsets.all(25.0),
            child: ToggleButtons(
              direction: Axis.horizontal,
              onPressed: setOptionMethod,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: optionSelections,
              children: <Widget>[
                Text(optionA),
                Text(optionB),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _canCheckInTask() {
    return option1Selections.contains(true) &&
        option2Selections.contains(true) &&
        option3Selections.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.station1Title),
        ),
        body: Container(
          padding: const EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: L.heightOfTaskDescription,
                child: Container(
                  padding: const EdgeInsets.all(25.0),
                  child: const Text(S.station1Task,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: L.fontSize)),
                ),
              ),
              _makeToggleButtonsFor(
                  S.station1Selection1Description,
                  S.station1Selection1OptionA,
                  S.station1Selection1OptionB,
                  _setOption1Selection,
                  option1Selections),
              _makeToggleButtonsFor(
                  S.station1Selection2Description,
                  S.station1Selection2OptionA,
                  S.station1Selection2OptionB,
                  _setOption2Selection,
                  option2Selections),
              _makeToggleButtonsFor(
                  S.station1Selection3Description,
                  S.station1Selection3OptionA,
                  S.station1Selection3OptionB,
                  _setOption3Selection,
                  option3Selections),
              Flexible(
                  flex: L.heightOfFooter,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<StateModel>(
                      builder: (BuildContext context, model, Widget? child) {
                        return TextButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text(S.done),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: _canCheckInTask() && !model.station1Checked
                              ? () {
                                  setState(() {
                                    model.station1SetChecked(true);
                                  });
                                }
                              : null,
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
