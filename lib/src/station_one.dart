import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ubermorgen.dart' show StateModel, S;

class StationOne extends StatelessWidget {
  const StationOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.station1Title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(S.station1Task),
          ElevatedButton(
            // style: style,
            onPressed: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => TakePictureScreen());
            },
            child: const Text('Take Picture'),
          ),
          ElevatedButton(
            // style: style,
            onPressed: () {
              Provider.of<StateModel>(context, listen: false)
                  .markAsDone(S.keyStation1);
            },
            child: const Text('Done'),
          ),
        ],
      )),
    );
  }
}
