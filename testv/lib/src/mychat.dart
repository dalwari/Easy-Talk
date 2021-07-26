import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'file.dart';

class MyChat extends StatefulWidget {
  final int index;
  dynamic data;
  MyChat({Key key, this.index, this.data}) : super(key: key);

  @override
  _MyChatState createState() =>
      _MyChatState(index: this.index, data: this.data);
}

class _MyChatState extends State<MyChat> {
  int index;
  dynamic data;
  _MyChatState({this.index, this.data});
  var _locale = getLocale();
  var _languages = getLanguages();
  FlutterTts tts = FlutterTts();
  void _speak(String text) async {
    await tts.setSpeechRate(1.0);
    await tts.setVolume(1.0);
    await tts.setPitch(0.9);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    /*return Container(
      margin: EdgeInsets.only(right: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(5),
            ),
             //padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: TextButton(
              onPressed: () {},
              child: Text(
                data['value'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 57))
        ],
      ),
    );*/
    return /*Align(
        alignment: Alignment.topRight, //default
        //alignment: Alignment.center,
        child:*/ Padding(
            //padding: EdgeInsets.only(top: 5.0, right: 20.0),
            padding: EdgeInsets.only(top: 5.0),
            child: Container(
                child: TextButton(
                  child: Column(
                    children: [
                      Text(
                        data['author'],
                        style: TextStyle(
                          color: Colors.amberAccent[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        data['value'],
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.teal[900],
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _locale = getLocale().toString();
                    tts.setLanguage("$_locale");
                    var msg = await '${data['value']}'
                        .translate(to: _locale.split('_')[0]);
                    setState(() {
                      data['value'] = msg.text;
                    });
                    _speak(msg.text);
                  },
                ),
                //constraints: BoxConstraints(maxWidth: 180.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.indigo[50],
                ))
                //)
                );
  }
}
