import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _amount;
  bool _reset = false;
  bool _popUp = false;
  int _number = -1;
  String? _message;
  final TextEditingController _controler = TextEditingController();

  void initNumber() {
    _message = null;
    final Random random = Random();
    _number = random.nextInt(100) + 1;
  }

  void generateMessage(int value) {
    if (value < _number) {
      _message = 'You tried $value\nTry higher';
    } else if (value > _number) {
      _message = 'You tried $value\nTry lower';
    } else {
      _reset = true;
      _popUp = true;
      _message = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            "I'm thinking of a number a number between 1 and 100.",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "It's your turn to guess my number!",
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          if (_message != null)
            Text(
              _message!,
              style: const TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Try a number',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    controller: _controler,
                    keyboardType: TextInputType.number,
                    onChanged: (String s) {
                      _amount = s;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: _reset ? const Text('Reset') : const Text('Guess'),
                      onPressed: () {
                        if (_reset = true) {
                          setState(
                            () {
                              _reset = false;
                              return;
                            },
                          );
                        }
                        if (_amount != null) {
                          try {
                            final int x = int.parse(_amount!);
                            setState(
                              () {
                                if (_number == -1) {
                                  initNumber();
                                }
                                generateMessage(x);
                              },
                            );
                          } on FormatException {
                            setState(
                              () {},
                            );
                          }
                        }
                        if (_popUp == true) {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('You guessed right'),
                              content: Text('It was $_number'),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Try again?'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _reset = false;
                                        _popUp = false;
                                        _number = -1;
                                        _controler.clear();
                                        _amount = '';
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        _reset = true;
                                        _popUp = false;
                                        _number = -1;
                                        _amount = '';
                                        _controler.clear();
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
