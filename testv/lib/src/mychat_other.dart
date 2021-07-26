import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import 'file.dart';
import 'try2.dart';

class OtherChat extends StatefulWidget {
  final int index;
  dynamic data;
  OtherChat({Key key, this.index, this.data}) : super(key: key);

  @override
  _OtherChatState createState() =>
      _OtherChatState(index: this.index, data: this.data);
}

class _OtherChatState extends State<OtherChat> {
  int index;
  dynamic data;
  _OtherChatState({this.index, this.data});
  var _locale = getLocale();
  var _languages = getLanguages();
  FlutterTts tts = FlutterTts();
  Future _speak(String text) async {
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
        
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 17,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(5)),
                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: TextButton(
              onPressed: () {},
            child:Text(
                    data['value'],
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.lime[900],
                        fontWeight: FontWeight.w400),
                  ),
            ),
          ),
          //Padding(padding: EdgeInsets.only(bottom: 87)),
        ],
      ),
    );*/
    return /*Align(
      alignment: Alignment.topLeft,
      child:*/ Padding(
        padding: EdgeInsets.only(top: 5.0, right: 20.0),
        child: Container(
            child: TextButton(
              child: Column(
                children: [
                  Text(
                  data['author'],
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                  Text(data['value'],
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.teal[900],
                      ))
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
            //constraints:BoxConstraints(maxWidth:180.0 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.blue[100],
            )),
    //  ),
    );
  }
}
