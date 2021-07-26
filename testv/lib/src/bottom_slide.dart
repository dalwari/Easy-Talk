import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'file.dart';
import 'package:testv/video_call.dart';
import 'try2.dart';

class ThirdClass extends StatefulWidget {
  ThirdClass({Key key}) : super(key: key);
  //include widget in store widget.store
  //final store = FirebaseFirestore.instance.collection('chat_messages');
  @override
  _ThirdClassState createState() => _ThirdClassState();
}

class _ThirdClassState extends State<ThirdClass> {
  var text_controller = TextEditingController();
  IconData mic_icon = Icons.mic_off_rounded;
  bool tap = false;
  bool available = false;
  var text_str = "nothing";
  IconButton _icon = null;
  stt.SpeechToText _speech = stt.SpeechToText();
  void initSpeech() async {
    available = await _speech.initialize(
      onStatus: (v) => print(v),
      onError: (v) => print(v),
    );
    /*if (available) {
      print("speech initialize");
    } else {
      print("speech else");
    }*/
  }
//include widget in store widget.store
  /*void _addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await store.add({
        'author': 'dummy2722',
        'author_id': user.uid,
        'value': value,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
      });
    }
  }*/

  @override
  void initState() {
    initSpeech();
    super.initState();
  }

  void _listen(bool tap) async {
    // debugPrint("AVAILABLE=> $available");
    var _locale = getLocale();

    if (tap == true) {
      debugPrint("SPEECH LOCALE=> $_locale");
      _speech.listen(
          //listenFor: Duration(minutes: 1),
          //pauseFor: Duration(minutes: 1),
          //cancelOnError: true,
          //onDevice: true,
          localeId: _locale,
          onResult: (v) => setState(() {
                text_controller.text = v.recognizedWords;
                addFunc(text_controller.text); //today
                //debugPrint("spoke=> ${text_controller.text}");
              }));
    }
    if (tap == false) {
      _speech.stop();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Align(
        //alignment: Alignment.bottomLeft,
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              /*RawMaterialButton(
                child: Icon(
                  mic_icon,
                  size: 30.0,
                ),
                onPressed: () async {
                  tap = !tap;
                  // print("MIC TAP=> $tap");
                  setState(() {
                    mic_icon = tap ? Icons.mic_rounded : Icons.mic_off_rounded;
                  });
                  _listen(tap);
                },
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
              ),*/
              /***today */
              IconButton(
                  onPressed: () async {
                    tap = !tap;
                    setState(() {
                      mic_icon =
                          tap ? Icons.mic_rounded : Icons.mic_off_rounded;
                    });
                    _listen(tap);
                    //_listen1();
                  },
                  icon: Icon(
                    mic_icon,
                    size: 30.0,
                    color: Colors.white,
                  )),
              /************ */
              Expanded(
                  child: Container(
                decoration: BoxDecoration(color: Colors.green[100]),
                child: TextField(
                  controller: text_controller,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'type',
                    hintText: 'speak or type',
                    suffixIcon: _icon,
                  ),
                  onChanged: (val) {
                    text_str = val;
                    //today
                    addFunc(text_controller.text);
                    //
                    // print("text_str=> ${text_controller.text}");
                    setState(() {
                      //_icon = Icon(Icons.cancel,);
                      _icon = IconButton(
                        icon: Icon(
                          Icons.cancel,
                        ),
                        onPressed: () {
                          //print("tapped");
                          text_controller.clear();
                          addFunc(text_controller.text);
                        },
                      );
                    });
                  },
                  maxLines: 5,
                  minLines: 1,
                  expands: false,
                ),
                /* padding: EdgeInsets.only(
                    //top: 120.0,
                    //left: 20.0,
                    right: 30.0,
                  )*/
              )),
              /****today */
              /* RawMaterialButton(
                child: Icon(
                  Icons.send_rounded,
                  size: 30.0,
                ),
                onPressed: () {
                  text_controller.text == null || text_controller.text.isEmpty
                      ? null
                      : addFunc(text_controller.text);
                  // : _addMessage(text_controller.text);
                  setState(() {
                    text_controller.clear();
                  });
                },
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
              ),*/
              /******* */
              IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.call_end,
                    size: 30.0,
                    color: Colors.red,
                  )),
            ],
          ),

          //Icon(Icons.mic_off_rounded),
        ),
      ),
    );
  }
}
