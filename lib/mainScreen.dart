import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String history = "";
  String output = "";
  String res = "0";
  String op = "";
  String oldop = "";
  int x = -1;
  int end = -1;
  double num1 = 0;
  double num2 = 0;

  Widget buildbutton(String value, int flex, int num) {
    return Expanded(
      flex: flex,
      child: Container(
alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xff22252d),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              if (end == 0) {
                res = ' ';
                num1 = num2 = 0.0;
                op = "";
                output = "";
                history = "";
                end = -1;
                x = -1;
              }
              if (value == 'AC') {
                res = '';
                num1 = num2 = 0;
                op = "";
                output = "";
                history = "";
              } else if (value == '.') {
                if (res.contains('.')) {
                  return;
                } else {
                  res = res + value;
                }
              } else if (value == '+' ||
                  value == '-' ||
                  value == '*' ||
                  value == '/' ||
                  value == '%') {
                // ignore: unnecessary_string_interpolations
                num1 = double.parse("$output");
                op = value;
                res = "";
              } else if (value == '=') {
                end = 0;
                x = 0;
                // ignore: unnecessary_string_interpolations
                num2 = double.parse("$output");
                if (op == '+') {
                  res = (num1 + num2).toString();
                } else if (op == '-') {
                  res = (num1 - num2).toString();
                } else if (op == '*') {
                  res = (num1 * num2).toString();
                } else if (op == '/') {
                  res = (num1 / num2).toString();
                } else if (op == '%') {
                  res = (num1 % num2).toString();
                }
                num1 = 0;
                num2 = 0;
                op = "";
              } else if (value == '<' && x == -1) {
                if (res.isNotEmpty && history.isNotEmpty) {
                  res = res.substring(0, res.length - 1);
                  history = history.substring(0, history.length - 1);
                } else {
                  if (history.isNotEmpty) {
                    history = history.substring(0, history.length - 1);
                    res = history;
                  } else {
                    return;
                  }
                }
              } else {
                if (value != "<") {
                  res = res + value;
                }
              }

              setState(() {
                output = res;
              });
              if (value != 'AC') {
                if (value != '<') {
                  history = history + value;
                }
              } else {
                history = '';
              }
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 40,
                  color: num == 0
                      ? Color(0xff26e1c0)
                      : num == 1
                          ? Color(0xffe87676)
                          : Color(0xffFFFFFF)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff292d36),
          title: const Center(
              child: Text(
            "Calculator",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
          ))),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff22252d),
        child: Column(
          children: [
            Expanded(child: Container()),
            //history
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12.5),
              child: Text(
                history,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            //output
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(12.5, 12.5, 12.5, 25),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 85,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(child: Container()),
            //buttons
            Container(
              padding: EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: Color(0xff292d36)
              ),
              child: Column(
                children: [
                  Row(children: [
                    buildbutton("AC", 2, 0),
                    buildbutton("%", 1, 0),
                    buildbutton("/", 1, 0),
                  ]),
                  Row(children: [
                    buildbutton("7", 1, 2),
                    buildbutton("8", 1, 2),
                    buildbutton("9", 1, 2),
                    buildbutton("*", 1, 1),
                  ]),
                  Row(children: [
                    buildbutton("4", 1, 2),
                    buildbutton("5", 1, 2),
                    buildbutton("6", 1, 2),
                    buildbutton("-", 1, 1),
                  ]),
                  Row(children: [
                    buildbutton("1", 1, 2),
                    buildbutton("2", 1, 2),
                    buildbutton("3", 1, 2),
                    buildbutton("+", 1, 1),
                  ]),
                  Row(children: [
                    buildbutton("0", 1, 2),
                    buildbutton(".", 1, 2),
                    buildbutton("<", 1, 2),
                    buildbutton("=", 1, 1),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
