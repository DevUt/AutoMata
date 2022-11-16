import 'package:flutter/material.dart';
import 'package:automata/DFA/dfa.dart';
import 'package:automata/NFA/nfa.dart';
import 'package:automata/GNFA/gnfa.dart';

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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(image: AssetImage('assets/insidelogo.png'))),
              Center(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DFACreateManual()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(style: TextStyle(fontSize: 15), "DFA"),
                      ),
                    )),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NFACreateManual()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(style: TextStyle(fontSize: 15), "NFA"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GNFACreateManual()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(style: TextStyle(fontSize: 15), "GNFA"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(style: TextStyle(fontSize: 15), "PDA"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(style: TextStyle(fontSize: 15), "TM"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
