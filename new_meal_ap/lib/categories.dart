import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your category"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView(
          // 그리드뷰의 자식들을 컨트롤하는 델리게이터
          // crossAxisCount : Left to right
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // 가로 세로 비율
            childAspectRatio: 3 / 2,
            // 수평방향 수직방향 각각 자식들간의 간격
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
          ),
          children: [
            Expanded(child: Container(color: Colors.white,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white12,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white24,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white38,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white54,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white60,child: const Text("1"),)),
            Expanded(child: Container(color: Colors.white70,child: const Text("1"),)),
          ],
        ),
      ),
    );
  }
}