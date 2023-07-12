import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // 메시지가 전송될 때 push notification 활성
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    // 사용자에거 알림 권한 요. 필수
    await fcm.requestPermission();
    // 기기에 할당되는 토큰,
    // BE 서버 디비에 저장하여 알림을 받을 수 있도록 함
    final token = await fcm.getToken();

    print("TOKEN $token}");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              // firebase token을 expired 하고
              // 메모리에 저장된 토큰을 섹저하여 로그아웃 처리
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            )
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages()
          ),
          NewMessage(),
        ],
      )
    );
  }
}