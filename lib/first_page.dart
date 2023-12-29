import 'package:flutter/material.dart';
import 'package:flutter_application_1/constraints.dart';
import 'package:flutter_application_1/resueable_box.dart';
import 'package:flutter_application_1/box_content.dart';
//import 'package:flutter_application_1/bluetooth.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirtPageState createState() => _FirtPageState();
}

class _FirtPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Mustairs'),
        centerTitle: true, // Set this to true to center the title
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/instruments.png',
                            color: Colors.white),
                        label: 'SELECT INSTRUMENT'),
                    onPress: () {
                      Navigator.pushNamed(context, '/input');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/console.png',
                            color: Colors.white),
                        label: 'GAME MODE'),
                    onPress: () {
                      Navigator.pushNamed(context, '/game');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
