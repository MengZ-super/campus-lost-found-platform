import 'package:flutter/material.dart';

class LostFoundDetailPage extends StatelessWidget {
  final int id;

  const LostFoundDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('物品详情')),
      body: Center(
        child: Text('物品 #$id 详情页（建设中）'),
      ),
    );
  }
}
