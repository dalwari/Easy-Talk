import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'display_wall.dart';
import 'try2.dart';

class DisplayChat extends StatefulWidget {
  DisplayChat({Key key}) : super(key: key);

  @override
  _DisplayChatState createState() => _DisplayChatState();
}

class _DisplayChatState extends State<DisplayChat> {
  dynamic msg = '';
  dynamic mesg;

  bool isOpen = false;
  var bottomSheetController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: store.orderBy('timestamp').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.isEmpty) {
                //if (true) {
                msg = 'EMPTY';
              } else {
                msg = 'NOT EMPTY';
                //msg = snapshot.data.docs[0].data()['value'];
                mesg = snapshot.data.docs;
                return DisplayWall(
                  messages: mesg,
                  onDelete: delFunc,
                );
              }
            }
            //to show empty as message
            /*return Padding(
                padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
                child: Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 5.0),
                      // padding: EdgeInsets.only( top: 5.0),
                      child: Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              msg,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue[100],
                          ))),
                ));*/
            return Container();
          }),

      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.green[400],
      ),*/
      height: 300.0,
      width: 400.0,
      //margin:EdgeInsets.only(top:45.0,bottom:75.0),
      margin: EdgeInsets.only(top: 220.0),
      // constraints: BoxConstraints(maxWidth: 300),
    );
  }
}
