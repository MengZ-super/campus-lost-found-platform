import 'package:flutter/material.dart';

class MyClaimsPage extends StatelessWidget {
  const MyClaimsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的认领')),
      body: const Center(
        child: Text('我的认领（建设中）'),
      ),
    );
  }
}
