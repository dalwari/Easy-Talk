import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'try2.dart';
//MessageWall
class ChatOne extends StatefulWidget {
  List<QueryDocumentSnapshot> message;
  //final ValueChanged<String> onDelete;
  //ChatOne({Key key, this.message,this.onDelete}) : super(key: key);
  ChatOne({Key key, this.message}) : super(key: key);
  //final store = FirebaseFirestore.instance.collection('chat_messages');

  @override
  _ChatOneState createState() => _ChatOneState();
}

class _ChatOneState extends State<ChatOne> {
  List<QueryDocumentSnapshot> _message;
  

  @override
  void initState() {
    _message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
      child: ListView.builder(
          itemCount: _message.length,
          itemBuilder: (context, index) {
            final data = _message[index].data();
            final user = FirebaseAuth.instance.currentUser;
            return Wrap(
              children: [
                getFunc(_message[index], data, user),
              ],
            );
          }),
    ));
  }

  Widget getFunc(dynamic message, dynamic data, dynamic user) {
    if (user != null && user.uid == data['author_id']) {
      {
        return Dismissible(
            //key: ValueKey(data['timestamp']),
            key: UniqueKey(),
            onDismissed: (_) {
              delFunc(message.id);
              
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 20.0),
                  child: Container(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          data['value'],
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.teal[900],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.indigo[50],
                      ))),
            ));
      }
    } else {
      return Padding(
          padding: EdgeInsets.only(left: 5.0, top: 5.0),
          child: Container(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  data['value'],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue[100],
              )));
    }
  }
}
/*Padding(
        padding: EdgeInsets.only(top: 70.0, bottom: 70.0),
        child: Container(
                child:
                //start
                 Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            _message[0].data()['value'],
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
                        //end
              ))
*/
