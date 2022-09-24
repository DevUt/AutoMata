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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transition function")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                }),
          ),
        ],
      ),
    );
  }

  Widget proceedButton() {
    return ElevatedButton(
        onPressed: () {
          Map<String, Map<String, String>> transitionFunction;
        },
        child: const Text("Proceed"));
  }
}
