import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _amount;
  bool _reset = false;
  bool _popUp = false;
  int _number = -1;
  String _message;
  final _controler = TextEditingController();

  void initNumber() {
    _message = null;
    Random random = new Random();
    _number = random.nextInt(100) + 1;
  }

  void generateMessage(int value) {
    if (value < _number) {
      _message = "You tried " + value.toString() + "\nTry higher";
    } else if (value > _number) {
      _message = "You tried " + value.toString() + "\nTry lower";
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
        title: Text("Guess my number"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "I'm thinking of a number a number between 1 and 100.",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "It's your turn to guess my number!",
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            if (_message != null)
              Text(
                _message,
                style: TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                  )
                ]),
                child: Column(
                  children: [
                    Text(
                      "Try a number",
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
                        }),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          child: _reset ? Text("Reset") : Text("Guess"),
                          onPressed: () {
                            if (_reset = true) {
                              setState(() {
                                _reset = false;
                                return;
                              });
                            }
                            if (_amount != null) {
                              try {
                                int x = int.parse(_amount);
                                setState(() {
                                  if (_number == -1) {
                                    initNumber();
                                  }
                                  generateMessage(x);
                                });
                              } on FormatException {
                                setState(
                                  () {},
                                );
                              }
                            }
                            if (_popUp == true) {
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("You guessed right"),
                                  content: Text("It was " + _number.toString()),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        child: Text("Try again?"),
                                        onPressed: () {
                                          setState(() {
                                            _reset = false;
                                            _popUp = false;
                                            _number = -1;
                                            _controler.clear();
                                            _amount = "";
                                            Navigator.of(context).pop();
                                          });
                                        }),
                                    ElevatedButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          setState(() {
                                            _reset = true;
                                            _popUp = false;
                                            _number = -1;
                                            _amount = "";
                                            _controler.clear();
                                            Navigator.of(context).pop();
                                          });
                                        }),
                                  ],
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
