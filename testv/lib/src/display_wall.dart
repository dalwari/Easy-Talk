import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mychat.dart';
import 'mychat_other.dart';
import 'try2.dart';

class DisplayWall extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;
  final ValueChanged<String> onDelete;
  const DisplayWall({
    Key key,
    this.messages,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final data = messages[index].data();
            //final user = FirebaseAuth.instance.currentUser;
            //try2.dart has user,store
            if (user != null && user.uid == data['author_id']) {
              return Dismissible(
                onDismissed: (_) {
                  onDelete(messages[index].id);
                },
                key: ValueKey(data['timestamp']),
                //key:UniqueKey(),
                //child:Text('MyMessage'),
                //child: Text('${data['value']}'),
                child:Container(
                  //alignment: Alignment.topRight,
                  alignment: Alignment.bottomRight,
                  child:MyChat(
                  index: index,
                  data: data,
                ),
                ), 
              );
            }
            //return Text('Other Message');
            return Container(
            //alignment: Alignment.topLeft,
            alignment: Alignment.bottomLeft,
            child:OtherChat(
              index: index,
              data: messages[index].data(),
            ));
            
          }),
    );
  }
}
