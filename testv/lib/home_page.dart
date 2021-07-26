import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './video_call.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<HomePage> {
  final _channelController = TextEditingController();
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    
      onWillPop: () {
        _signOut();
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(' Join Conversation '),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
        ),
        body:Stack(
          children: [
            Container(
               
               child:Positioned.fill(child:Image.asset('assets/images/join1.jpg',fit:BoxFit.cover,), ),
               
             ),
            Align(
              alignment: Alignment.bottomCenter,
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 20.0),
            //color: Colors.amber[200],
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 270,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          color: Colors.white,
                          child:    TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                        
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Channel name',
                      
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500, ),
                    ))
                        ),
                    
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.amber[50],
                      child: ListTile(
                      title: Text(ClientRole.Broadcaster.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 17.0)),
                      leading: Radio(
                        value: ClientRole.Broadcaster,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    ),
                    
                    ),
                    Container(
                      color:Colors.amber[50],
                      child:ListTile(
                      title: Text(ClientRole.Audience.toString(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 17.0),),
                      leading: Radio(
                        value: ClientRole.Audience,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    ),
                    ),
                    
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: onJoin,
                          child: Text('ENTER'),
                          //color: Colors.blueAccent,
                          color: Colors.blue[700],
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        
          ],
        ),
        
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
