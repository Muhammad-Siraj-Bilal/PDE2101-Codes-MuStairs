import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constraints.dart';
import 'package:flutter_application_1/resueable_box.dart';
import 'package:flutter_application_1/box_content.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/src/audio_cache.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  BluetoothConnection? connection;
  StreamSubscription<Uint8List>? streamSubscription;
  bool isConnecting = true;
  bool get isConnected => connection?.isConnected ?? false;

  String deviceAddress = "98:D3:71:FD:DA:06";

  // AudioPlayer? _player;
  // final player = AudioPlayer();

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
    // String receivedString = String.fromCharCodes(data);
    // print('Received data: $receivedString');

    // if (receivedString == '1') {
    //   // Play sound for '1'
    //   _play('a4.wav');
    // } else if (receivedString == '2') {
    //   // Play sound for '2'
    //   _play('c4.wav');
    // }
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

  // void _play(String FileName) {
  //   player.play(AssetSource(FileName));
  // final player = AudioCache();
  // player.play(FileName);
  // }

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
        title: Text('Select the Instrument'),
        centerTitle: true,
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
                    cardChild: BoxContent(
                        icon: Image.asset('assets/guitar.png',
                            color: Colors.white),
                        label: 'GUITAR'),
                    onPress: () {
                      _sendMessage('1');
                      // _play('a42.mp3');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon:
                            Image.asset('assets/drum.png', color: Colors.white),
                        label: 'DRUM'),
                    onPress: () {
                      _sendMessage('2');
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
                    cardChild: BoxContent(
                        icon: Image.asset('assets/piano.png',
                            color: Colors.white),
                        label: 'PIANO'),
                    onPress: () {
                      _sendMessage('3');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/flute.png',
                            color: Colors.white),
                        label: 'FLUTE'),
                    onPress: () {
                      _sendMessage('4');
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
                    cardChild: BoxContent(
                        icon: Image.asset('assets/violin.png',
                            color: Colors.white),
                        label: 'VIOLIN'),
                    onPress: () {
                      _sendMessage('5');
                    },
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kReusableCardColor,
                    cardChild: BoxContent(
                        icon: Image.asset('assets/organ.png',
                            color: Colors.white),
                        label: 'ORGAN'),
                    onPress: () {
                      _sendMessage('6');
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
