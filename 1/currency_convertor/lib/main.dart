import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  String amount;
  String wrongInput;
  double result = 0;
  bool changed = false;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency convertor"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiJOwdFGpRWm6qEoO-DBm8X1AbRLasm5G5woAdrUns9GVwM8BL-5XVZQ5OCFZRj98j-q4&usqp=CAU",
                  scale: 0.75,
                )
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter the amount in EUR",
                errorText: wrongInput
              ),
              onChanged: (String s) {
                amount = s;
              }
            ),
            ElevatedButton(
              child: Text(
                "Convert"
              ),
              onPressed: () {
                  if(amount == null) {
                    setState(() {
                      wrongInput = 'please enter a number';
                    },);
                  }else {
                    try{
                      var x = double.parse(amount);
                      setState(() {
                        result = 4.5 * x;
                        changed = true;
                        wrongInput = null;
                      });
                    } on FormatException {
                      setState(() {
                        wrongInput = 'please enter a number';
                      },);
                    }
                  }
              }
            ),
            Text(
                changed == true ? result.toStringAsFixed(2) + " RON" : "",
                textScaleFactor: 2,
            )

          ],
        ),
      ),
    );
  }
}

