import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'try1.dart';
import 'try2.dart';
class ChatNow extends StatefulWidget {
  ChatNow({Key key}) : super(key: key);
 // final store = FirebaseFirestore.instance.collection('chat_messages');
  @override
  _ChatNowState createState() => _ChatNowState();
}

class _ChatNowState extends State<ChatNow> {
  List<QueryDocumentSnapshot> mesg;
  dynamic msg='';
  /*void _deleteMessage(String docId) async {
    await widget.store.doc(docId).delete();
  }*/
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: store.orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
            //if (true) {
              msg = 'EMPTY';
            } else {
              //msg = 'NOT EMPTY';
              //msg = snapshot.data.docs[0].data()['value'];
              mesg = snapshot.data.docs;
              return ChatOne(message: mesg,);
            }
          }
          return Padding(
              padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
              child: Container(
                child: Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0),
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
              ));
        });
  }
}
