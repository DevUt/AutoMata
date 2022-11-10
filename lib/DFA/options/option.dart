import 'package:automata_library/automata_library.dart';
import 'package:flutter/material.dart';

class OptionsMenu extends StatefulWidget {
  DFA DFAobj;

  OptionsMenu({Key? key, required this.DFAobj}) : super(key: key);

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  @override
  Widget build(BuildContext context) {
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
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: Icon(Icons.account_circle),
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
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.account_circle),
                title: Text('Each stage transitions'),
                subtitle:
                    Text("returns step wise transitions for each alphabet"),
                onTap: () {
                  print(widget.DFAobj.validate().toString());
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.account_circle),
                title: Text('Test DFA'),
                subtitle: Text("Custom test inputs for your DFA"),
                onTap: () {
                  print(widget.DFAobj.validate().toString());
                },
              ),
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
}
