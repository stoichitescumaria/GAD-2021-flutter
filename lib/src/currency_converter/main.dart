import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  String? amount;
  String? wrongInput;
  double result = 0;
  bool changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency convertor'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiJOwdFGpRWm6qEoO-DBm8X1AbRLasm5G5woAdrUns9GVwM8BL-5XVZQ5OCFZRj98j-q4&usqp=CAU',
            scale: 0.75,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Enter the amount in EUR', errorText: wrongInput),
            onChanged: (String s) {
              amount = s;
            },
          ),
          ElevatedButton(
            child: const Text('Convert'),
            onPressed: () {
              if (amount == null) {
                setState(
                      () {
                    wrongInput = 'please enter a number';
                  },
                );
              } else {
                try {
                  final double x = double.parse(amount!);
                  setState(
                        () {
                      result = 4.5 * x;
                      changed = true;
                      wrongInput = null;
                    },
                  );
                } on FormatException {
                  setState(
                        () {
                      wrongInput = 'please enter a number';
                    },
                  );
                }
              }
            },
          ),
          Text(
            changed == true ? '${result.toStringAsFixed(2)} RON' : '',
            textScaleFactor: 2,
          )
        ],
      ),
    );
  }
}
