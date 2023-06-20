import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ubermorgen.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.introTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog.fullscreen(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        S.imprint,
                        style: TextStyle(fontSize: L.fontSize),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Schliessen',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Spiel Zurücksetzen'),
                  content: const Text('Wirklich alles Löschen?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Abbrechen'),
                      child: const Text('Abbrechen'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<StateModel>(context, listen: false).reset();
                        Navigator.pop(context, 'Abbrechen');
                      },
                      child: const Text('Ja, alles Löschen!'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Consumer<StateModel>(
                builder: (context, model, child) {
                  bool done = model.station1Checked;
                  return StationField(done, S.titleStation1, S.imageStation1);
                },
              ),
              Consumer<StateModel>(
                builder: (context, model, child) {
                  bool done = model.station2Checked;
                  return StationField(done, S.titleStation2, S.imageStation2);
                },
              ),
              Consumer<StateModel>(
                builder: (context, model, child) {
                  bool done = model.station3Checked;
                  return StationField(done, S.titleStation3, S.imageStation3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StationField extends StatelessWidget {
  final bool done;
  final String title;
  final String iconname;

  const StationField(this.done, this.title, this.iconname, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: done
              ? const Color.fromARGB(255, 224, 255, 227)
              : Colors.green[100],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(height: 8),
          ImageIcon(AssetImage('assets/images/$iconname'), size: 75),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              switch (title) {
                case S.titleStation1:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StationOne()));
                  break;
                case S.titleStation2:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StationTwo()));
                  break;
                case S.titleStation3:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StationThree()));
              }
            },
            child: done ? const Text("Ansehen") : const Text("Starten"),
          )
        ],
      ),
    );
  }
}
