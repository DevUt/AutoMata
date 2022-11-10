import 'package:flutter/material.dart';
import 'package:automata/DFA/dfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoMata',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(title: 'AutoMata'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                margin: EdgeInsets.all(10),
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DFACreateManual()));
                  },
                  child: const Text("DFA"),
                )),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              width: 200,
              child: ElevatedButton(onPressed: () {}, child: const Text("NFA")),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              width: 200,
              child: ElevatedButton(onPressed: () {}, child: const Text("PDA")),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              width: 200,
              child: ElevatedButton(onPressed: () {}, child: const Text("TM")),
            ),
          ),
        ],
      ),
    );
  }
}
