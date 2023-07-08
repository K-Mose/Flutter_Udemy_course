import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late User user;
  late DocumentSnapshot<Map<String, dynamic>> userInfo;

  @override
  void initState() {
    super.initState();
    setUserInfo();
  }
  
  void setUserInfo() async {
    user = FirebaseAuth.instance.currentUser!;
    userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    // focus 상태 해제, 키보드 닫음
    FocusScope.of(context).unfocus();
    _messageController.clear();

    FirebaseFirestore.instance
        .collection("chat")
        // 동적으로 문서 삽입. firestore에서 id 생성
        .add({
          'text': enteredMessage,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'userName': userInfo.data()!['username'],
          'userImage': userInfo.data()!['image_url'],
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
              decoration: const InputDecoration(labelText: "Send a Message"),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitMessage,
            icon: const Icon(Icons.send)
          ),
        ],
      ),
    );
  }
}
