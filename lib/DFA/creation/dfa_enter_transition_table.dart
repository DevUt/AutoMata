import 'package:automata/DFA/options/option.dart';
import 'package:automata/widget/transition/transition_table.dart';
import 'package:automata_library/automata_library.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class DFAEnterTransitionTable extends StatefulWidget {
  final DFA? dfa;
  final List<String> alphabet;
  final List<String> states;
  final List<String> acceptingStates;
  final String initialState;

  const DFAEnterTransitionTable(
      {super.key,
      required this.alphabet,
      required this.states,
      required this.acceptingStates,
      required this.initialState,
      required this.dfa});

  @override
  State<DFAEnterTransitionTable> createState() =>
      _DFAEnterTransitionTableState();
}

class _DFAEnterTransitionTableState extends State<DFAEnterTransitionTable> {
  late List<List<TextEditingController>> controllers;
  late List<TextEditingController> statesController;
  late List<TextEditingController> alphabetController;
  late List<List<TextEditingController>> cellsController;
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _headController;
  late ScrollController _bodyController;
  late int row, col;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transition function"),
        actions: [proceedButton(controllers, row, col)],
      ),
      body: Column(
        children: [
          TableHorizontalHead(
              scrollController: _headController,
              horizontalHeaderControllor: controllers[0].sublist(1)),
          Expanded(
              child: TransitionTableBody(
            scrollController: _bodyController,
            verticalHeaderControllor: statesController,
            horizontalHeaderControllor: alphabetController,
            cellsController: cellsController,
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();

    row = widget.states.length;
    col = widget.alphabet.length;

    controllers = List.generate((row + 1),
        (i) => List.generate((col + 1), (i) => TextEditingController()));
    loadData(controllers, row, col);
    statesController =
        List.generate((row), (index) => controllers[index + 1][0]);
    alphabetController =
        List.generate((col), (index) => controllers[0][index + 1]);
    cellsController =
        List.generate(row, (index) => controllers[index + 1].sublist(1));
    if (widget.dfa != null) {
      for (int i = 0; i < alphabetController.length; i++) {
        alphabetController[i].text = widget.dfa!.alphabet.elementAt(i);
      }
      for (int i = 0; i < statesController.length; i++) {
        statesController[i].text = widget.dfa!.states.elementAt(i);
      }

      for (int i = 0; i < (statesController.length); i++) {
        for (int j = 0; j < (alphabetController.length); j++) {
          cellsController[i][j].text = widget.dfa!.transitionFunction[
              statesController[i].text]![alphabetController[j].text]!;
        }
      }
    }
  }

  @override
  void dispose() {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
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

  Widget proceedButton(
      List<List<TextEditingController>> controllers, int row, int col) {
    return IconButton(
        onPressed: () {
          Map<String, Map<String, String>> transFn = {};
          for (int i = 1; i < (row + 1); i++) {
            Map<String, String> innerMap = {};
            for (int j = 1; j < (col + 1); j++) {
              innerMap.addAll({controllers[0][j].text: controllers[i][j].text});
            }
            transFn.addAll({controllers[i][0].text: innerMap});
          }
          DFA obj = DFA(
              alphabet: (widget.alphabet).toSet(),
              initialState: widget.initialState,
              acceptingStates: (widget.acceptingStates).toSet(),
              states: (widget.states).toSet(),
              transitionFunction: transFn);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OptionsMenu(dfaObj: obj)));
        },
        icon: const Icon(
          Icons.check,
          color: Colors.amber,
        ));
  }
}
