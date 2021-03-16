import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculater());
}

class Calculater extends StatefulWidget {
  @override
  _CalculaterState createState() => _CalculaterState();
}

class _CalculaterState extends State<Calculater> {
  //history

  List<Text> equationHistory = [];
  //variables
  var equation = "0";
  var result = "0";
  var expression = "";

  //function
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "<-") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        equation = result;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  //build container
  Container buildContainer(String buttonText, Color color) {
    return Container(
      // margin: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
          child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      )),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple[900],
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$equation",
                        style: TextStyle(
                            color: Colors.deepPurple[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "$result",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 3),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "equationHistory",
                              style: TextStyle(color: Colors.deepPurple[100]),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.keyboard_arrow_left,
                                  color: Colors.white, size: 24),
                              Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white, size: 24),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                height: 200,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 160,
                      child: buildContainer("C", Colors.deepPurple[300])),
                  buildContainer("<-", Colors.deepPurple[300]),
                  // buildContainer("%", Colors.deepPurple[300]),
                  buildContainer("÷", Colors.deepOrangeAccent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer("7", Colors.deepPurple),
                  buildContainer("8", Colors.deepPurple),
                  buildContainer("9", Colors.deepPurple),
                  buildContainer("×", Colors.deepOrangeAccent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer("4", Colors.deepPurple),
                  buildContainer("5", Colors.deepPurple),
                  buildContainer("6", Colors.deepPurple),
                  buildContainer("-", Colors.deepOrangeAccent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer("1", Colors.deepPurple),
                  buildContainer("2", Colors.deepPurple),
                  buildContainer("3", Colors.deepPurple),
                  buildContainer("+", Colors.deepOrangeAccent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    child: buildContainer("0", Colors.deepPurple),
                  ),
                  buildContainer(".", Colors.deepPurple),
                  buildContainer("=", Colors.deepOrangeAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
