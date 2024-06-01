// // // in this part of code we are sending and  getting messages from fire store

import 'package:chat_app/widgets/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      final token = await fcm.getToken();
      print('This is your token: $token');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    fcm.subscribeToTopic('CHAT'); // Subscribe to the 'CHAT' topic
  }

  @override
  //here we call setupPushNotification function bcz it is (future function) and init  state did not suppoert future function so we create and call that inside in it state
  void initState() {
    super.initState();
    setupPushNotification();
  }

  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt', // Corrected typo here
            descending: true, // for showing the latest messages at last
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (chatSnapshots.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Text('No messages found'),
          );
        }

        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(left: 3, right: 13, bottom: 40),
          reverse: true, // to move messages upword
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            // final messageData =
            //      loadedMessages[index].data() as Map<String, dynamic>;
            // return Text(messageData['text'] ?? 'No text');

            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            final currentMessageUsername = chatMessage['email'];
            final nextMessageUsername =
                nextChatMessage != null ? nextChatMessage['email'] : null;
            final nextUserisSame = nextMessageUsername ==
                currentMessageUsername; // for checking that the next message is from same user or not

            if (nextUserisSame) {
              return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: authenticatedUser.uid == currentMessageUsername);
            } else {
              return MessageBubble.first(
                  // userImage: chatMessage['Userimage'],
                  //  userImage: chatMessage['Userimage'],
                  userImage: chatMessage['Userimage'],
                  username: chatMessage['email'],
                  message: chatMessage['text'],
                  isMe: authenticatedUser.uid == currentMessageUsername);
            }
          },
        );
      },
    );
  }
}
