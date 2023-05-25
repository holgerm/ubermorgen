import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state_model.dart';

class StationOne extends StatelessWidget {
  const StationOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station 1 ...'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text("Hierhin kommt der Inhalt für Station 1."),
          ElevatedButton(
            // style: style,
            onPressed: () {
              Provider.of<StateModel>(context, listen: false)
                  .markAsDone('station1');
            },
            child: const Text('Disabled'),
          ),
        ],
      )),
    );
  }
}
