import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {

  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // firebase의 chat 컬렉션을 지속적으로 listen 하여 데이터 변화(새로운 doc 추가) 감지
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy("createdAt", descending: false)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        // 데이터 수신 중
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 받은 메시지가 없을 때
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Message Found")
          );
        }

        // 에러 확인
        if (chatSnapshots.hasError) {
          return const Center(
              child: Text("Something went wrong...")
          );
        }
        final loadedMessage = chatSnapshots.data!.docs;
        return ListView.builder(
          itemCount: loadedMessage.length,
          itemBuilder: (context, index) => Card(
              child: Text(loadedMessage[index].data()['text']),
            ),
        );
      },
    );
  }
}