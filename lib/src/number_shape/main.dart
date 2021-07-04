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
  late String? _amount;
  final TextEditingController _controller = TextEditingController();

  String printInfo() {
    _controller.clear();
    final int number = int.parse(_amount!);
    double root = sqrt(number);
    bool square = false;
    bool triangular = false;
    if (root % 1 == 0) {
      square = true;
    }
    root = pow(number, 1 / 3) as double;
    if (root % 1 == 0) {
      triangular = true;
    }
    if (triangular && square) {
      return 'Number $number is both SQUARE AND TRIANGULAR.';
    } else if (square) {
      return 'Number $number is SQUARE.';
    } else if (triangular) {
      return 'Number $number is TRIANGULAR.';
    }
    return 'Number $number is neither SQUARE AND TRIANGULAR.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Please input a number to see if it is square or triangular.',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            onChanged: (String s) {
              _amount = s;
            },
          ),
        ],
      ),
      floatingActionButton: IconButton(
        disabledColor: Colors.black,
        hoverColor: Colors.lightBlueAccent,
        icon: const Icon(
          Icons.check,
          color: Colors.blue,
        ),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(_amount!),
              content: Text(printInfo()),
            ),
          );
        },
      ),
    );
  }
}
