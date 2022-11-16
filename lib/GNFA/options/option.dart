import 'package:automata/DFA/creation/dfa_create_manual.dart';
import 'package:automata_library/automata_library.dart';
import 'package:flutter/material.dart';

import '../../widget/helper.dart';

class OptionsMenu extends StatefulWidget {
  final GNFA gnfaObj;

  const OptionsMenu({Key? key, required this.gnfaObj}) : super(key: key);

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  bool testEnableFlag = false;
  bool stepEnableFlag = false;
  bool epsilonClosureField = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController testReadinp = TextEditingController();
    TextEditingController testSetout = TextEditingController();
    TextEditingController testOutstate = TextEditingController();

    TextEditingController stepReadinp = TextEditingController();
    TextEditingController stepSetout = TextEditingController();
    TextEditingController stepOutstates = TextEditingController();

    TextEditingController epsilonClosureState = TextEditingController();
    TextEditingController epsilonClosureOutput = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: amberText("Operations on GNFA"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Validate'),
                  subtitle: const Text("returns whether gnfa is valid or not"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('GNFA Validation result')),
                      content: decide(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Each stage transitions'),
                  subtitle: const Text(
                      "returns step wise transitions for each alphabet"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 1),
                                  child: const Text(
                                      'Enter Custom test Input for step wise transitions')),
                              content: Wrap(children: [
                                Column(
                                  children: [
                                    TextField(
                                      controller: stepReadinp,
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
                                    Visibility(
                                      visible: stepEnableFlag,
                                      child: TextField(
                                        controller: stepSetout,
                                        enabled: true,
                                      ),
                                    ),
                                    Visibility(
                                      visible: stepEnableFlag,
                                      child: TextField(
                                        controller: stepOutstates,
                                        enabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      stepReadinp.clear();
                                      stepEnableFlag = false;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Back")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        stepEnableFlag = true;
                                      });
                                      stepWiseInputTest(stepReadinp, stepSetout,
                                          stepOutstates);
                                    },
                                    child: const Text("Go"))
                              ],
                            );
                          });
                        });
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Test GNFA'),
                  subtitle: const Text("Custom test inputs for your GNFA"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 1),
                                  child:
                                      const Text('Enter Custom test Inputs')),
                              content: Wrap(children: [
                                Column(
                                  children: [
                                    TextField(
                                      controller: testReadinp,
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
                                    Visibility(
                                      visible: testEnableFlag,
                                      child: TextField(
                                        controller: testSetout,
                                        enabled: true,
                                      ),
                                    ),
                                    Visibility(
                                      visible: testEnableFlag,
                                      child: TextField(
                                        controller: testOutstate,
                                        enabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      testReadinp.clear();
                                      testEnableFlag = false;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Back")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        testEnableFlag = true;
                                      });
                                      test(testReadinp, testSetout,
                                          testOutstate);
                                    },
                                    child: const Text("Go"))
                              ],
                            );
                          });
                        });
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Check for Reachable states'),
                  subtitle:
                      const Text("Gives you the states that are reachable"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('Reachable States:-')),
                      content: reachableStates(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back")),
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Check for Unreachable states'),
                  subtitle:
                      const Text("Gives you the states that are Unreachable"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('Unreachable States :-')),
                      content: unreachableStates(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back")),
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Check for Dead states'),
                  subtitle: const Text("Gives you the states that are Dead"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('Dead States :-')),
                      content: deadStates(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back")),
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Convert GNFA to DFA'),
                  subtitle: const Text("Gives you the DFA conversion of NFA"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DFACreateManual(
                          dfa: widget.gnfaObj.convertNfaToDfa());
                    }));
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Epsilon Closure for specific state'),
                  subtitle: const Text(
                      "Gives you the epsilon closure of a specific state"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 1),
                                  child: const Text('Enter input state')),
                              content: Wrap(children: [
                                Column(
                                  children: [
                                    TextField(
                                      controller: epsilonClosureState,
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
                                    Visibility(
                                      visible: epsilonClosureField,
                                      child: TextField(
                                        controller: epsilonClosureOutput,
                                        enabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      epsilonClosureState.clear();
                                      epsilonClosureField = false;
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Back")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        epsilonClosureField = true;
                                      });
                                      epsilonClosure(epsilonClosureState,
                                          epsilonClosureOutput);
                                    },
                                    child: const Text("Go"))
                              ],
                            );
                          });
                        });
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: leadingIcon(),
                  title: const Text('Generate Regex'),
                  subtitle: const Text(
                      "Gives you the regular expression for your GNFA"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('Regex :-')),
                      content: Regex(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back")),
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
          ],
        ));
  }

  Widget decide() {
    if (widget.gnfaObj.validate()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Validation Success"),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Validation Failure"),
      ],
    );
  }

  void test(TextEditingController readinp, TextEditingController setout,
      TextEditingController outstate) {
    String userinput = readinp.text;

    try {
      Set<String> exitStates = widget.gnfaObj.testInput(userinput.split(''));
      setout.text =
          (widget.gnfaObj.acceptingStates.intersection(exitStates).isNotEmpty)
              ? "Decision : Accepted"
              : "Decision : Rejected";
      outstate.text = "Custom input ended on state $exitStates";
    } catch (e) {
      setout.text = "Decision : Invalid input";
      outstate.text = "Invalid symbol detected";
    }
  }

  void stepWiseInputTest(TextEditingController stepReadinp,
      TextEditingController stepSetout, TextEditingController stepOutstates) {
    String userinput = stepReadinp.text;

    try {
      Set<Set<String>> returnval =
          widget.gnfaObj.testStepWiseInput(userinput.split(''));
      stepSetout.text = "The custom input visits these states :-";
      stepOutstates.text = returnval.join(' ');
    } catch (e) {
      stepSetout.text = "Invalid Input";
      stepOutstates.text = "No states visited";
    }
  }

  Widget reachableStates() {
    String reachableState = widget.gnfaObj.computeReachableStates().join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(reachableState),
      ],
    );
  }

  Widget unreachableStates() {
    Set<String> reachableStateToConvert =
        widget.gnfaObj.computeReachableStates();
    String unreachableState =
        widget.gnfaObj.states.difference(reachableStateToConvert).join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        unreachableState.isEmpty
            ? const Text("Empty", style: TextStyle(color: Colors.red))
            : Text(unreachableState)
      ],
    );
  }

  Widget deadStates() {
    String deadState = widget.gnfaObj.computeDeadStates().join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        deadState.isEmpty
            ? const Text("Empty", style: TextStyle(color: Colors.red))
            : Text(deadState)
      ],
    );
  }

  void epsilonClosure(TextEditingController epsilonClosureState,
      TextEditingController epsilonClosureOutput) {
    String epsilonClosureInput = epsilonClosureState.text;
    try {
      epsilonClosureOutput.text =
          widget.gnfaObj.epsilonClosureOfState(epsilonClosureInput).toString();
    } catch (e) {
      epsilonClosureOutput.text = "Invalid Input";
    }
  }

  Widget Regex() {
    String regex = widget.gnfaObj.regex();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        regex.isEmpty
            ? const Text("Empty", style: TextStyle(color: Colors.red))
            : Text(regex)
      ],
    );
  }
}
