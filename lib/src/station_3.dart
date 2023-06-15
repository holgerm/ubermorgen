import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ubermorgen.dart' show L, S, StateModel;

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: L.heightOfTaskDescription,
              child: Container(
                padding: const EdgeInsets.all(25.0),
                child: const Text(
                  S.station3Task,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: L.fontSize),
                ),
              ),
            ),
            const Flexible(
              flex: L.heightOfContent,
              child: ProductListView(),
            ),
            Flexible(
              flex: L.heightOfFooter,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Consumer<StateModel>(
                  builder: (BuildContext context, model, Widget? child) {
                    return Row(
                      children: [
                        Text(_getFeedbackText(model)),
                        TextButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text(S.done),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: !model.station3Checked
                              ? () {
                                  setState(() {
                                    model.station3SetChecked(true);
                                  });
                                }
                              : null,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getFeedbackText(model) {
    if (!model.station3Checked) return '';

    if (model.numberOfErrors > 0) {
      return 'Du hast ${model.numberOfErrors} Produkte falsch angeordnet.\nDu kannst sie aber weiterhin verschieben, um die richtige Lösung zu sehen.';
    } else {
      return 'Perfekte Lösung! Genauso stimmt alles.';
    }
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(
      builder: (BuildContext context, model, Widget? child) {
        return ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          buildDefaultDragHandles: false,
          children: <Widget>[
            for (List it in model.items)
              ReorderableDragStartListener(
                key: Key(it[0]),
                index: model.items.indexOf(it),
                child: ListTile(
                  //key: Key(it[0]),
                  leading: Container(
                      margin: const EdgeInsets.all(5),
                      child:
                          ImageIcon(AssetImage('images/${it[2]}'), size: 55)),
                  title: Text(
                    it[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: it[1] as Color,
                  textColor: it[1].computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  trailing: _getCorrectIcon(it, model),
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final List item = model.removeItemAt(oldIndex);
            model.insert(newIndex, item);
          },
        );
      },
    );
  }
}

_getCorrectIcon(List it, StateModel model) {
  if (!model.station3Checked) return null;

  if (model.items.indexOf(it) == it[3]) {
    return const Icon(Icons.check, color: Colors.greenAccent);
  } else {
    return const Icon(Icons.warning_outlined, color: Colors.redAccent);
  }
}
