import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class TransitionTableCell extends StatefulWidget {
  final TextEditingController controller;
  final bool isEnabled;
  const TransitionTableCell(
      {super.key, required this.controller, required this.isEnabled});

  @override
  State<TransitionTableCell> createState() => _TransitionTableCellState();
}

class _TransitionTableCellState extends State<TransitionTableCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: TextField(
          enabled: widget.isEnabled,
          controller: widget.controller,
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
  }
}

class TableHorizontalHead extends StatefulWidget {
  final ScrollController scrollController;
  final List<TextEditingController> horizontalHeaderControllor;
  const TableHorizontalHead(
      {super.key,
      required this.scrollController,
      required this.horizontalHeaderControllor});

  @override
  State<TableHorizontalHead> createState() => _TableHorizontalHeadState();
}

class _TableHorizontalHeadState extends State<TableHorizontalHead> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          TransitionTableCell(
            controller: TextEditingController(),
            isEnabled: false,
          ),
          Expanded(
              child: ListView(
                  controller: widget.scrollController,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      widget.horizontalHeaderControllor.length,
                      (index) => TransitionTableCell(
                          controller: widget.horizontalHeaderControllor[index],
                          isEnabled: false)))),
        ],
      ),
    );
  }
}

class TransitionTableBody extends StatefulWidget {
  final ScrollController scrollController;
  final List<TextEditingController> verticalHeaderControllor;
  final List<TextEditingController> horizontalHeaderControllor;
  final List<List<TextEditingController>> cellsController;
  const TransitionTableBody(
      {super.key,
      required this.scrollController,
      required this.verticalHeaderControllor,
      required this.horizontalHeaderControllor,
      required this.cellsController});

  @override
  State<TransitionTableBody> createState() => _TransitionTableBodyState();
}

class _TransitionTableBodyState extends State<TransitionTableBody> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _firstColumnController;
  late ScrollController _restColumnsController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _firstColumnController = _controllers.addAndGet();
    _restColumnsController = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _firstColumnController.dispose();
    _restColumnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: ListView(
            controller: _firstColumnController,
            physics: const ClampingScrollPhysics(),
            children: List.generate(
                widget.verticalHeaderControllor.length,
                (index) => TransitionTableCell(
                    controller: widget.verticalHeaderControllor[index],
                    isEnabled: false)),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                controller: widget.scrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  width: (widget.horizontalHeaderControllor.length) * 100,
                  child: ListView(
                    controller: _restColumnsController,
                    physics: const ClampingScrollPhysics(),
                    children: List.generate(
                        widget.verticalHeaderControllor.length, (vIndex) {
                      return Row(
                          children: List.generate(
                              widget.horizontalHeaderControllor.length,
                              (hIndex) => TransitionTableCell(
                                  controller: widget.cellsController[vIndex]
                                      [hIndex],
                                  isEnabled: true)));
                    }),
                  ),
                ))),
      ],
    );
  }
}
