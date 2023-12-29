import 'package:flutter/material.dart';
import 'package:flutter_application_1/constraints.dart';
import 'package:flutter_application_1/resueable_box.dart';
import 'package:flutter_application_1/box_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  BluetoothConnection? connection;
  StreamSubscription<Uint8List>? streamSubscription;
  bool isConnecting = true;
  bool get isConnected => connection?.isConnected ?? false;

  String deviceAddress = "98:D3:71:FD:DA:06";

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(deviceAddress).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
      });

      streamSubscription = connection!.input!.listen(_onDataReceived);
      streamSubscription!.onDone(() {
        if (isConnected) {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred');
      print(error);
    });
  }

  void _onDataReceived(Uint8List data) {
    String receivedString = String.fromCharCodes(data);
    print('Received data: $receivedString');

    if (receivedString == '1') {
      Navigator.pushNamed(context, '/congrats');
    }
  }

  void _sendMessage(String text) async {
    if (connection == null) {
      print('No connection to a device');
      return;
    }

    if (isConnected) {
      connection!.output.add(Uint8List.fromList(utf8.encode(text)));
      await connection!.output.allSent;
      print('Message sent');
    } else {
      print('No device connected');
    }
  }

  @override
  void dispose() {
    // Avoid memory leaks and disconnect properly
    streamSubscription?.cancel(); // Cancel the stream subscription
    if (isConnected) {
      connection!.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the Game'),
        centerTitle: true, // Set this to true to center the title
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music, label: 'TWINKLE TWINKLE'),
                    onPress: () {
                      _sendMessage('a');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music,
                        label: 'MARY HAD A LITTLE LAMB'),
                    onPress: () {
                      _sendMessage('b');
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music,
                        label: 'BA BA BLACK SHEEP'),
                    onPress: () {
                      _sendMessage('c');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music, label: 'JOHNNY JOHHNY'),
                    onPress: () {
                      _sendMessage('d');
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music, label: 'LONDON BRIDGE'),
                    onPress: () {
                      _sendMessage('e');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent2(
                        icon: FontAwesomeIcons.music, label: 'HUMPTY DUMPTY'),
                    onPress: () {
                      _sendMessage('f');
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
