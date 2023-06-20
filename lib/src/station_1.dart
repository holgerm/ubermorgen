import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ubermorgen.dart' show L, S, StateModel;

class StationOne extends StatefulWidget {
  const StationOne({super.key});

  @override
  State<StationOne> createState() => _StationOneState();
}

class _StationOneState extends State<StationOne> {
  _makeToggleButtonsFor(
      String description,
      final String optionA,
      final String optionB,
      Function(int) setOptionMethod,
      List<bool> optionSelections) {
    return Flexible(
      flex: (L.heightOfContent / 6.0).round(),
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
          child: Consumer<StateModel>(
            builder: (BuildContext context, model, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: L.heightOfTaskDescription,
                    child: Container(
                      padding: const EdgeInsets.all(25.0),
                      child: const Text(
                        S.station1Task,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: L.fontSize),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: L.heightOfContent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _makeToggleButtonsFor(
                                S.station1SelectionADescription,
                                S.station1SelectionAOption1,
                                S.station1SelectionAOption2,
                                model.setOption1Selection,
                                model.option1Selections),
                            _makeToggleButtonsFor(
                                S.station1SelectionBDescription,
                                S.station1SelectionBOption1,
                                S.station1SelectionBOption2,
                                model.setOption2Selection,
                                model.option2Selections),
                            _makeToggleButtonsFor(
                                S.station1SelectionCDescription,
                                S.station1SelectionCOption1,
                                S.station1SelectionCOption2,
                                model.setOption3Selection,
                                model.option3Selections),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 500,
                              height: 350,
                              child:
                                  Image.asset('assets/images/s1_original.png'),
                            ),
                            Consumer<StateModel>(
                              builder:
                                  (BuildContext context, model, Widget? child) {
                                return SizedBox(
                                  width: 500,
                                  height: 350,
                                  child: Image.asset(model.option1Selections[0]
                                      ? 'assets/images/s1_a1.png'
                                      : 'assets/images/s1_a2.png'),
                                );
                              },
                            ),
                            Consumer<StateModel>(
                              builder:
                                  (BuildContext context, model, Widget? child) {
                                return SizedBox(
                                  width: 500,
                                  height: 350,
                                  child: Image.asset(model.option2Selections[0]
                                      ? 'assets/images/s1_b1.png'
                                      : 'assets/images/s1_b2.png'),
                                );
                              },
                            ),
                            Consumer<StateModel>(
                              builder:
                                  (BuildContext context, model, Widget? child) {
                                return SizedBox(
                                  width: 500,
                                  height: 350,
                                  child: Image.asset(model.option3Selections[0]
                                      ? 'assets/images/s1_c1.png'
                                      : 'assets/images/s1_c2.png'),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: L.heightOfFooter,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Consumer<StateModel>(
                        builder: (BuildContext context, model, Widget? child) {
                          return TextButton.icon(
                            icon: const Icon(Icons.check),
                            label:
                                Text(model.station1Checked ? S.done : S.todo),
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed:
                                model.canCheckInTask() && !model.station1Checked
                                    ? () {
                                        setState(() {
                                          model.station1SetChecked(true,
                                              model.makeImageNameFromOptions());
                                        });
                                      }
                                    : null,
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
