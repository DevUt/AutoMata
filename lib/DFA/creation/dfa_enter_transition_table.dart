import 'package:flutter/material.dart';

class DFAEnterTransitionTable extends StatefulWidget {
  final List<String> alphabet;
  final List<String> states;
  final List<String> acceptingStates;
  final String initialState;

  const DFAEnterTransitionTable(
      {super.key,
      required this.alphabet,
      required this.states,
      required this.acceptingStates,
      required this.initialState});

  @override
  State<DFAEnterTransitionTable> createState() =>
      _DFAEnterTransitionTableState();
}

class _DFAEnterTransitionTableState extends State<DFAEnterTransitionTable> {
  late List<List<TextEditingController>> controllers;

  late int row, col;

  @override
  Widget build(BuildContext context) {
    row = widget.states.length;
    col = widget.alphabet.length;
    controllers = List.generate((row + 1),
        (i) => List.generate((col + 1), (i) => TextEditingController()));

    return Scaffold(
      appBar: AppBar(title: const Text("Transition function")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: (row + 1) * (col + 1),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: col + 1),
                  itemBuilder: (ctx, index) {
                    int crow = (index / (col + 1)).floor();
                    int ccol = index % (col + 1);
                    Widget cont = SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Center(
                        child: TextField(
                          enabled: (crow != 0 && ccol != 0) ? true : false,
                          controller: controllers[crow][ccol],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.amber,
                            )),
                          ),
                          style: const TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    );
                    loadData(controllers, row, col);
                    return cont;
                  }),
            ),
          ),
        ),
      ),
    );
  }

  /// Loads the default content for the transition table
  void loadData(
      List<List<TextEditingController>> controllers, int row, int col) {
    for (int i = 1; i < (col + 1); i++) {
      controllers[0][i].text = widget.alphabet[i - 1];
    }
    for (int i = 1; i < (row + 1); i++) {
      controllers[i][0].text = widget.states[i - 1];
    }
  }

  Widget proceedButton() {
    return ElevatedButton(
        onPressed: () {
          Map<String, Map<String, String>> transitionFunction;
        },
        child: const Text("Proceed"));
  }
}
