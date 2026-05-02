import 'package:flutter/material.dart';

class MyPublishesPage extends StatelessWidget {
  const MyPublishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的发布')),
      body: const Center(
        child: Text('我的发布（建设中）'),
      ),
    );
  }
}
