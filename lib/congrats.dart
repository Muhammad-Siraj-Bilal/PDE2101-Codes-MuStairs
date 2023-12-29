import 'package:flutter/material.dart';
import 'package:flutter_application_1/constraints.dart';

class CongratsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Go back to continue'),
          centerTitle: true, // Set this to true to center the title
        ),
        body: Align(
          alignment: Alignment.center,
          child: Text(
              '       Congratulations! 🎉' '\n' 'You have cleared the song',
              style: kLabelTextStyle3),
        ));
  }
}
