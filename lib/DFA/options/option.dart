import 'package:automata/widget/helper.dart';
import 'package:automata_library/automata_library.dart';
import 'package:flutter/material.dart';

class OptionsMenu extends StatefulWidget {
  final DFA dfaObj;

  const OptionsMenu({Key? key, required this.dfaObj}) : super(key: key);

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  bool testEnableFlag = false;
  bool stepEnableFlag = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController testReadinp = TextEditingController();
    TextEditingController testSetout = TextEditingController();
    TextEditingController testOutstate = TextEditingController();

    TextEditingController stepReadinp = TextEditingController();
    TextEditingController stepSetout = TextEditingController();
    TextEditingController stepOutstates = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: amberText("Operations on DFA"),
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
                  subtitle: const Text("returns whether dfa is valid or not"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: const Text('DFA Validation result')),
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
                                      step_wise(stepReadinp, stepSetout,
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
                  title: const Text('Test DFA'),
                  subtitle: const Text("Custom test inputs for your DFA"),
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
                  title: const Text('Generate Regex'),
                  subtitle: const Text(
                      "Gives you the regular expression for your DFA"),
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
                            child: const Text("OK"))
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
          ],
        ));
  }

  Widget deadStates() {
    String deadState = widget.dfaObj.computeDeadStates().join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        deadState.isEmpty
            ? const Text("Empty", style: TextStyle(color: Colors.red))
            : Text(deadState)
      ],
    );
  }

  Widget decide() {
    if (widget.dfaObj.validate()) {
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

  Widget reachableStates() {
    String reachableState = widget.dfaObj.computeReachableStates().join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(reachableState),
      ],
    );
  }

  void step_wise(TextEditingController stepReadinp,
      TextEditingController stepSetout, TextEditingController stepOutstates) {
    String userinput = stepReadinp.text;

    try {
      List<String> returnval =
          widget.dfaObj.testStepwiseInput(userinput.split(''));
      stepSetout.text = "The custom input visits these states :-";
      stepOutstates.text = returnval.join(' ');
    } catch (e) {
      stepSetout.text = "Invalid Input";
      stepOutstates.text = "No states visited";
    }
  }

  void test(TextEditingController readinp, TextEditingController setout,
      TextEditingController outstate) {
    String userinput = readinp.text;

    try {
      String exitstate = widget.dfaObj.testInput(userinput.split(''));
      bool ans = widget.dfaObj.isAcceptingState(exitstate);
      setout.text = (ans) ? "Decision : Accepted" : "Decision : Rejected";
      outstate.text = "Custom input ended on state $exitstate";
    } catch (e) {
      setout.text = "Decision : Invalid input";
      outstate.text = "Invalid symbol detected";
    }
  }

  Widget unreachableStates() {
    Set<String> reachableStateToConvert =
        widget.dfaObj.computeReachableStates();
    String unreachableState =
        widget.dfaObj.states.difference(reachableStateToConvert).join(' ');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        unreachableState.isEmpty
            ? const Text("Empty", style: TextStyle(color: Colors.red))
            : Text(unreachableState)
      ],
    );
  }

  Widget Regex() {
    String regex = GNFA.fromDFA(widget.dfaObj).regex();
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
