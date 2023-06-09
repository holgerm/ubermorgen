import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ubermorgen.dart' show L, S, StateModel;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class StationTwo extends StatefulWidget {
  const StationTwo({super.key});

  @override
  State<StationTwo> createState() => _StationTwoState();
}

class _StationTwoState extends State<StationTwo> {
  bool canBeMarkedDone = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.station2Title),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 20,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    S.station2Task,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: L.fontSizeSubTitle),
                  ),
                ),
              ),
              Flexible(
                flex: 45,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 460,
                        child: Image.asset('assets/images/windraeder.jpg'),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      const Expanded(
                        child: Text(
                          S.station2TaskDetails,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: L.fontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 30,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountDown(),
                      ResultArea(),
                    ],
                  ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class Station2Task1 extends StatelessWidget {
  const Station2Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountDown(),
          ResultArea(),
          Footer(),
        ],
      ),
    );
  }
}

class ResultArea extends StatefulWidget {
  const ResultArea({super.key});

  @override
  State<StatefulWidget> createState() => _ResultAreaState();
}

class _ResultAreaState extends State<ResultArea> {
  double _curSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(
      builder: (context, model, child) {
        _curSliderValue = model.numberOfWindmills.toDouble();
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Ich habe ",
              style: TextStyle(fontSize: L.fontSize),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Slider(
                value: _curSliderValue,
                max: 10,
                divisions: 10,
                label: _curSliderValue.round().toString(),
                onChanged: model.station2TaskCompleted && !model.station2Checked
                    ? (double value) {
                        setState(() {
                          _curSliderValue = value;
                          model
                              .station2SetNumberOfWindmillsBuilt(value.round());
                          model.station2SetTaskCompleted();
                        });
                      }
                    : null,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              model.station2GetNumberOfWindmillsText(),
              style: const TextStyle(fontSize: L.fontSize),
            ),
            const SizedBox(width: 25.0),
          ],
        );
      },
    );
  }
}

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int timeLeft = 60;
  bool started = false;
  Timer? currentTimer;
  late ByteData timerData;
  late Uint8List timerBytes;
  late ByteData alarmData;
  late Uint8List alarmBytes;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Wenn ihr auf „Start“ drückt, läuft die Zeit.",
          style: TextStyle(fontSize: L.fontSize),
        ),
        const SizedBox(width: 80),
        Consumer<StateModel>(
          builder: (BuildContext context, model, Widget? child) {
            return FilledButton(
              onPressed: started || model.station2Checked ? null : _startTimer,
              child: const Text(S.start),
            );
          },
        ),
        const SizedBox(width: 80),
        Text(
          "Verbleibende Zeit: $timeLeft Sekunden",
          style: const TextStyle(fontSize: L.fontSize),
        ),
      ],
    );
  }

  @override
  void dispose() {
    currentTimer?.cancel();
    player.dispose();
    super.dispose();
  }

  void _startTimer() {
    started = true;
    playTimer();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTimer = timer;
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(S.station2TimeOutTitle),
              content: const Text(S.station2TimeOutSubTitle),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          playAlarm();
          timer.cancel();
          Provider.of<StateModel>(context, listen: false)
              .station2SetTaskCompleted();
        }
      });
    });
  }

  Future<void> playTimer() async {
    await player.play(AssetSource("audio/timer.mp3"));
  }

  Future<void> playAlarm() async {
    await player.play(AssetSource("audio/alarm.mp3"));
  }
}

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 15,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<StateModel>(
            builder: (BuildContext context, model, Widget? child) {
              return FilledButton.icon(
                icon: const Icon(Icons.check),
                label: Text(model.station2Checked ? S.done : S.todo),
                style: FilledButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: model.station2TaskCompleted && !model.station2Checked
                    ? () {
                        setState(() {
                          model.station2SetChecked(
                              true); // is marked done so it cann not be marked again.
                        });
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Noch eine Bitte:"),
                            content: const Text(
                                "Bitte baut die Windräder für die nächste Gruppe wieder ab."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  model.station2SetInteractionFinished();
                                  Navigator.pop(context);
                                  if (model.allStationsFinishedInteractions()) {
                                    //L.playWin();
                                    model.showFinalDialog(context);
                                  }
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
