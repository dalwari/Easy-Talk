import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var store = FirebaseFirestore.instance.collection('chat_us');
var user = FirebaseAuth.instance.currentUser;
var _docId=user.uid;
void addFunc(String value) async {
  if (user != null) {
/*    await store.add({
      'author': user.displayName ?? 'Anonymous',
      'author_id': user.uid,
      'value': value,
      'timestamp': Timestamp.now().millisecondsSinceEpoch,
    });*/
    await store.doc(user.uid).set(
      {
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'value': value,
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
      },
    );
  }
}

void delFunc(String docId) async {
  await store.doc(docId).delete();
}

void onExit() async {
  await store.doc(_docId).delete();
}
