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
          ImageIcon(AssetImage('images/$iconname'), size: 75),
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
