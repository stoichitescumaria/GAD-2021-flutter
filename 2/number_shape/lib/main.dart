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
  final _controler = TextEditingController();
  String printInfo() {
      _controler.clear();
      int number =  int.parse(_amount);
      double root = sqrt(number);
      bool square = false;
      bool triangular = false;
      if(root % 1 == 0) {
        square = true;
      }
      root = pow(number, 1/3);
      if(root % 1 == 0) {
        triangular = true;
      }
      if(triangular && square) {
        return "Number " + number.toString() + " is both SQUARE AND TRIANGULAR.";
      } else if(square) {
        return "Number " + number.toString() + " is SQUARE.";
      } else if(triangular) {
        return "Number " + number.toString() + " is TRIANGULAR.";
      }
      return "Number " + number.toString() + " is neither SQUARE AND TRIANGULAR.";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Shapes"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Please input a number to see if it is square or triangular.",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
                controller: _controler,
                keyboardType: TextInputType.number,
                onChanged: (String s) {
                  _amount = s;
                }),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        disabledColor: Colors.black,
        hoverColor: Colors.lightBlueAccent,
        icon: const Icon(
          Icons.check,
          color: Colors.blue,
        ),
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(_amount),
              content: Text(printInfo()),
            ),
          );
        },
      ),
    );
  }
}
