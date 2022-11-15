import 'package:flutter/material.dart';
import 'package:automata_library/automata_library.dart';
import 'package:automata/DFA/creation/dfa_enter_transition_table.dart';

class DFACreateManual extends StatefulWidget {
  DFA? dfa;
  DFACreateManual({super.key, this.dfa});

  @override
  State<DFACreateManual> createState() => _DFACreateManualState();
}

class _DFACreateManualState extends State<DFACreateManual> {
  ///boolean flag to enable/disable the controllers
  bool enableFlag = true;

  ///Controller for alphabet input
  final alphabetInputController_ = TextEditingController();

  ///Controller for state Input
  final stateInputController_ = TextEditingController();

  ///Controller for accepting state input
  final acceptingStateInputController_ = TextEditingController();

  ///Controller for accepting state input
  final initialStateInputController_ = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.dfa != null) {
      enableFlag = false;
      alphabetInputController_.text = widget.dfa!.alphabet.join(',');
      stateInputController_.text = widget.dfa!.states.join(',');
      acceptingStateInputController_.text =
          widget.dfa!.acceptingStates.join(',');
      initialStateInputController_.text = widget.dfa!.initialState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manual DFA Creation"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              width: 100,
              height: 20,
            ),
            alphabetInput(),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            stateInput(),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            acceptingStateInput(),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            initialStateInput(),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            enterTransitionFunctionButton(),
          ],
        ),
      ),
    );
  }

  /// TextFormField for alphabet of the DFA. Currently we expect a comma
  /// separated list of symbols.
  Widget alphabetInput() {
    return TextFormField(
      controller: alphabetInputController_,
      enabled: enableFlag,
      decoration: const InputDecoration(
        labelText: "Alphabet",
        helperText: "Enter symbols separated by comma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for states of the DFA. Currently we expect a comma
  /// separated list of symbols
  Widget stateInput() {
    return TextFormField(
      controller: stateInputController_,
      enabled: enableFlag,
      decoration: const InputDecoration(
        labelText: "States",
        helperText: "Enter states separated by coma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for accepting states of the DFA. Currently we expect a comma
  /// separated list of symbols
  Widget acceptingStateInput() {
    return TextFormField(
      controller: acceptingStateInputController_,
      enabled: enableFlag,
      decoration: const InputDecoration(
        labelText: "Accepting States",
        helperText: "Enter states separated by coma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for initial state of the DFA.
  Widget initialStateInput() {
    return TextFormField(
      controller: initialStateInputController_,
      enabled: enableFlag,
      decoration: const InputDecoration(
        labelText: "Initial States",
        helperText: "Enter initial state",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// Button to enter transition function page
  Widget enterTransitionFunctionButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DFAEnterTransitionTable(
                    alphabet: alphabetInputController_.text.split(","),
                    states: stateInputController_.text.split(","),
                    acceptingStates:
                        acceptingStateInputController_.text.split(","),
                    initialState: initialStateInputController_.text,
                    dfa: widget.dfa)));
      },
      child: const Text("Enter Transition table"),
    );
  }
}
