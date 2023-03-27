import 'dart:async';

import 'package:jasur/esasy.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    open_app();
    super.initState();
  }

  open_app() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Esasy(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
          //vertically align center
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset("assets/etut.png")),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "OGUZ HAN ENGINEERING AND",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "TECHNOLOGY UNIVERSITY OF ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "TURKMENISTAN",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            //  Text(
            //   "OGUZ HAN ENGINEERING AND \n TECHNOLOGY UNIVERSITY OF \n TURKMENISTAN",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            // ),
          ]),
    ));
  }
}
