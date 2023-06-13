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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(25.0),
              child: const Text(
                S.station2Task,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: L.fontSize),
              ),
            ),
            const Station2Task1(),
          ],
        )),
      ),
    );
  }
}

class Station2Task1 extends StatelessWidget {
  const Station2Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Station2Model(),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CountDown(),
            ResultArea(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Station2Model extends ChangeNotifier {
  bool taskCompleted = false;
  bool canBeMarkedDone = false;

  void setTaskCompleted() {
    taskCompleted = true;
    notifyListeners();
  }

  void setCanBeMarkedAsDone() {
    canBeMarkedDone = true;
    notifyListeners();
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
    return Consumer<Station2Model>(
      builder: (context, model, child) {
        bool taskCompleted = model.taskCompleted;
        return Slider(
          value: _curSliderValue,
          max: 20,
          divisions: 20,
          label: _curSliderValue.round().toString(),
          onChanged: taskCompleted // && !model.canBeMarkedDone
              ? (double value) {
                  setState(() {
                    _curSliderValue = value;
                    model.setCanBeMarkedAsDone();
                  });
                }
              : null,
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
  late Timer currentTimer;
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
        Text(timeLeft.toString()),
        FilledButton(
          onPressed: started ? null : _startTimer,
          child: const Text('Start'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    currentTimer.cancel();
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
          Provider.of<Station2Model>(context, listen: false).setTaskCompleted();
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
    return Align(
      alignment: Alignment.bottomRight,
      child: Consumer<Station2Model>(
        builder: (BuildContext context, model, Widget? child) {
          return TextButton.icon(
            icon: const Icon(Icons.check),
            label: const Text(S.done),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: model.canBeMarkedDone
                ? () {
                    setState(() {
                      if (model.canBeMarkedDone) {
                        Provider.of<StateModel>(context, listen: false)
                            .markAsDone(S.keyStation1);
                        model.canBeMarkedDone =
                            false; // is marked done so it cann not be marked again.
                      }
                    });
                  }
                : null,
          );
        },
      ),
    );
  }
}
