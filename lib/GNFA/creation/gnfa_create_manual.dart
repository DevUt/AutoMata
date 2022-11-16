import 'package:automata/GNFA/creation/gnfa_enter_transition_table.dart';
import 'package:flutter/material.dart';
import 'package:automata/NFA/creation/nfa_enter_transition_table.dart';

class GNFACreateManual extends StatefulWidget {
  const GNFACreateManual({super.key});

  @override
  State<GNFACreateManual> createState() => _GNFACreateManualState();
}

class _GNFACreateManualState extends State<GNFACreateManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manual GNFA Creation"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            alphabetInput(),
            const SizedBox(
              height: 20,
            ),
            stateInput(),
            const SizedBox(
              height: 20,
            ),
            acceptingStateInput(),
            const SizedBox(
              height: 20,
            ),
            initialStateInput(),
            const SizedBox(
              height: 20,
            ),
            enterTransitionFunctionButton(),
          ],
        ),
      ),
    );
  }

  ///Controller for alphabet input
  final alphabetInputController_ = TextEditingController();

  ///Controller for state Input
  final stateInputController_ = TextEditingController();

  ///Controller for accepting state input
  final acceptingStateInputController_ = TextEditingController();

  ///Controller for accepting state input
  final initialStateInputController_ = TextEditingController();

  /// TextFormField for alphabet of the NFA. Currently we expect a comma
  /// separated list of symbols.
  Widget alphabetInput() {
    return TextFormField(
      controller: alphabetInputController_,
      decoration: const InputDecoration(
        labelText: "Alphabet",
        helperText: "Enter symbols separated by comma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for states of the NFA. Currently we expect a comma
  /// separated list of symbols
  Widget stateInput() {
    return TextFormField(
      controller: stateInputController_,
      decoration: const InputDecoration(
        labelText: "States",
        helperText: "Enter states separated by coma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for accepting states of the NFA. Currently we expect a comma
  /// separated list of symbols
  Widget acceptingStateInput() {
    return TextFormField(
      controller: acceptingStateInputController_,
      decoration: const InputDecoration(
        labelText: "Accepting States",
        helperText: "Enter states separated by coma(,)",
        border: OutlineInputBorder(),
      ),
    );
  }

  /// TextFormField for initial state of the NFA.
  Widget initialStateInput() {
    return TextFormField(
      controller: initialStateInputController_,
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
                builder: (context) => GNFAEnterTransitionTable(
                    alphabet: alphabetInputController_.text.split(","),
                    states: stateInputController_.text.split(","),
                    acceptingStates:
                        acceptingStateInputController_.text.split(","),
                    initialState: initialStateInputController_.text)));
      },
      child: const Text("Enter Transition table"),
    );
  }
}
