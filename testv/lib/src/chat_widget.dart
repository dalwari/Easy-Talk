import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'chat.dart';
import 'file.dart';

class SecondClass extends StatefulWidget {
  SecondClass({Key key}) : super(key: key);

  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass> {
  var _locale = getLocale();
  FlutterTts tts = FlutterTts();
  Future _speak(String text) async {
      await tts.setSpeechRate(1.0);
      await tts.setVolume(1.0);
      await tts.setPitch(0.9);
      await tts.speak(text);
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
        child: ListView.builder(
          itemCount: recv_msg.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 10.0,
          ),
          itemBuilder: (context, index) {
            return Wrap(
              children: [
                //start
                Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Container(
                        child: TextButton(
                          child: Text(
                            recv_msg[index],
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                            ),
                          ),
                          onPressed: () async {
                            //print("received tapped");
                            _locale = getLocale().toString();
                            var msg = await '${recv_msg[index]}'.translate(to: _locale.split('_')[0]);
                            setState(() {
                            recv_msg[index] = msg.text;
                            });
                            _speak(msg.text);
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue[100],
                        ))),
                //end
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0, right: 20.0),
                    child: Container(
                        child: TextButton(
                          child: Text(
                            send_msg[index],
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.teal[900],
                            ),
                          ),
                          onPressed: () async {
                            _locale = getLocale().toString();
                            var msg = await '${send_msg[index]}'.translate(to: _locale.split('_')[0]);
                            setState(() {
                            send_msg[index] = msg.text;
                            });
                            _speak(msg.text);
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.indigo[50],
                        )),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
