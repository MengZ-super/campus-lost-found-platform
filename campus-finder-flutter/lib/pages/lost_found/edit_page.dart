import 'package:flutter/material.dart';

class EditLostFoundPage extends StatelessWidget {
  final int id;

  const EditLostFoundPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('编辑信息')),
      body: Center(
        child: Text('编辑页 #$id（建设中）'),
      ),
    );
  }
}
