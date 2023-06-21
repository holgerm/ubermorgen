import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ubermorgen/src/state_model.dart';
import 'ubermorgen.dart' show L, S;
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
          padding: const EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: L.heightOfTaskDescription,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: const Text(
                      S.station2Task,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: L.fontSize),
                    ),
                  ),
                ),
                Flexible(
                  flex: L.heightOfContent,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }
}

class Station2Task1 extends StatelessWidget {
  const Station2Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 25.0),
            Text(
              model.station2GetNumberOfWindmillsText(),
              style: const TextStyle(fontSize: L.fontSize),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Slider(
                value: _curSliderValue,
                max: 20,
                divisions: 20,
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
  int timeLeft = 10;
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Verbleibende Zeit: $timeLeft Sekunden",
          style: const TextStyle(fontSize: L.fontSize),
        ),
        Consumer<StateModel>(
          builder: (BuildContext context, model, Widget? child) {
            return FilledButton(
              onPressed: started || model.station2Checked ? null : _startTimer,
              child: const Text(S.start),
            );
          },
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
      flex: L.heightOfFooter,
      child: Align(
        alignment: Alignment.centerRight,
        child: Consumer<StateModel>(
          builder: (BuildContext context, model, Widget? child) {
            return TextButton.icon(
              icon: const Icon(Icons.check),
              label: Text(model.station2Checked ? S.done : S.todo),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: model.station2TaskCompleted && !model.station2Checked
                  ? () {
                      setState(() {
                        model.station2SetChecked(
                            true); // is marked done so it cann not be marked again.
                      });
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}
