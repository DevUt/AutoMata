import 'package:automata_library/automata_library.dart';
import 'package:flutter/material.dart';

class OptionsMenu extends StatefulWidget {
  DFA DFAobj;

  OptionsMenu({Key? key, required this.DFAobj}) : super(key: key);

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  bool test_enableflag = false;
  bool step_enableflag = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController test_readinp = TextEditingController();
    TextEditingController test_setout = TextEditingController();
    TextEditingController test_outstate = TextEditingController();

    TextEditingController step_readinp = TextEditingController();
    TextEditingController step_setout = TextEditingController();
    TextEditingController step_outstates = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Operations on DFA"),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(Icons.settings),
                  title: Text('Validate'),
                  subtitle: Text("returns whether dfa is valid or not"),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 1),
                          child: Text('DFA Validation result')),
                      content: decide(),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"))
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(Icons.settings),
                  title: Text('Each stage transitions'),
                  subtitle:
                      Text("returns step wise transitions for each alphabet"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                  margin: EdgeInsets.fromLTRB(20, 5, 20, 1),
                                  child: Text(
                                      'Enter Custom test Input for step wise transitions')),
                              content: Wrap(children: [
                                Column(
                                  children: [
                                    TextField(
                                      controller: step_readinp,
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
                                      visible: step_enableflag,
                                      child: TextField(
                                        controller: step_setout,
                                        enabled: true,
                                      ),
                                    ),
                                    Visibility(
                                      visible: step_enableflag,
                                      child: TextField(
                                        controller: step_outstates,
                                        enabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      step_readinp.clear();
                                      step_enableflag = false;
                                      Navigator.pop(context);
                                    },
                                    child: Text("Back")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        step_enableflag = true;
                                      });
                                      step_wise(step_readinp, step_setout,
                                          step_outstates);
                                    },
                                    child: Text("Go"))
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
                    side: BorderSide(color: Colors.amber, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(Icons.settings),
                  title: Text('Test DFA'),
                  subtitle: Text("Custom test inputs for your DFA"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                  margin: EdgeInsets.fromLTRB(20, 5, 20, 1),
                                  child: Text('Enter Custom test Inputs')),
                              content: Wrap(children: [
                                Column(
                                  children: [
                                    TextField(
                                      controller: test_readinp,
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
                                      visible: test_enableflag,
                                      child: TextField(
                                        controller: test_setout,
                                        enabled: true,
                                      ),
                                    ),
                                    Visibility(
                                      visible: test_enableflag,
                                      child: TextField(
                                        controller: test_outstate,
                                        enabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      test_readinp.clear();
                                      test_enableflag = false;
                                      Navigator.pop(context);
                                    },
                                    child: Text("Back")),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        test_enableflag = true;
                                      });
                                      test(test_readinp, test_setout,
                                          test_outstate);
                                    },
                                    child: Text("Go"))
                              ],
                            );
                          });
                        });
                  }),
            ),
          ],
        ));
  }

  Widget decide() {
    if (widget.DFAobj.validate()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Validation Success"),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Validation Failure"),
      ],
    );
  }

  void test(TextEditingController readinp, TextEditingController setout,
      TextEditingController outstate) {
    String userinput = readinp.text;

    try {
      String exitstate = widget.DFAobj.testInput(userinput.split(''));
      bool ans = widget.DFAobj.isAcceptingState(exitstate);
      setout.text = (ans) ? "Decision : Accepted" : "Decision : Rejected";
      outstate.text = "Custom input ended on state $exitstate";
    } catch (e) {
      setout.text = "Decision : Invalid input";
      outstate.text = "Invalid symbol detected";
    }
  }

  void step_wise(TextEditingController step_readinp,
      TextEditingController step_setout, TextEditingController step_outstates) {
    String userinput = step_readinp.text;

    try {
      List<String> returnval =
          widget.DFAobj.testStepwiseInput(userinput.split(''));
      step_setout.text = "The custom input visits these states :-";
      step_outstates.text = returnval.join(' ');
    } catch (e) {
      step_setout.text = "Invalid Output";
      step_outstates.text = "No states visited";
    }
  }
}
