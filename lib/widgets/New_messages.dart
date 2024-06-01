//import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final enterMessage = _messageController.text;
    if (enterMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();
    // send to firbase
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser!;
    // final postRef = FirebaseDatabase.instance.ref().child('chat');
    //FirebaseStorage storage = FirebaseStorage.instance;

    final userData = await FirebaseFirestore.instance
        .collection('user data')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enterMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'email': userData.data()!['email'],
      'Userimage': userData.data()!['Userimage'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(labelText: 'Send a message....'),
          )),
          IconButton(
            onPressed: _submitMessage,
            icon: Icon(Icons.send),
            color: Color.fromARGB(160, 18, 130, 145),
          )
        ],
      ),
    );
  }
}
