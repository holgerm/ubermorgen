import 'package:flutter/material.dart';
import 'ubermorgen.dart' show S;

class StationThree extends StatefulWidget {
  const StationThree({super.key});

  @override
  State<StationThree> createState() => _StationThreeState();
}

class _StationThreeState extends State<StationThree> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(S.station3Title),
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    child: IndexedStack(
                      index: index,
                      children: const <Widget>[
                        Station3Task1(),
                        Station3Task2()
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: index == 0
                              ? null
                              : () {
                                  setState(() {
                                    index = 0;
                                  });
                                },
                          child: const Text('Zurück')),
                      ElevatedButton(
                          onPressed: index == 1
                              ? null
                              : () {
                                  setState(() {
                                    index = 1;
                                  });
                                },
                          child: const Text('Weiter')),
                    ],
                  )
                ]),
          )),
    );
  }
}

class Station3Task1 extends StatefulWidget {
  const Station3Task1({super.key});

  @override
  State<StatefulWidget> createState() => _Station3Task1State();
}

class _Station3Task1State extends State<Station3Task1> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/memory.jpg',
          height: 300,
          width: 300,
          fit: BoxFit.contain,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const Text(
                  S.station3Task1Description,
                ),
                CheckboxListTile(
                  value: checkboxValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkboxValue = value!;
                    });
                  },
                  title: const Text('Erledigt'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Station3Task2 extends StatefulWidget {
  const Station3Task2({super.key});

  @override
  State<StatefulWidget> createState() => _Station3Task2State();
}

class _Station3Task2State extends State<Station3Task2> {
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Column(
          children: [
            const Text(
              S.station3Task2Description,
            ),
            CheckboxListTile(
              value: checkboxValue,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValue = value!;
                });
              },
              title: const Text('Erledigt'),
            ),
          ],
        ),
      ),
      const Placeholder(),
    ]);
  }
}
