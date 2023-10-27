import 'package:flutter/material.dart';
import 'package:blockchain_implementation/contanst.dart';

class CustomButton extends StatelessWidget {
  String text;
  Function handleTap;
  CustomButton({this.text, this.handleTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Container(
            margin: EdgeInsets.all(10.0),
            width: 600.0,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
            child: Text(
              "$text",
              textAlign: TextAlign.center,
              style: ktextStyle,
            )));
  }
}
